import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/dependencies.dart';
import '../../../core/analytics/analytics_event.dart';
import '../../../core/errors/app_exception.dart';
import '../domain/quiz_models.dart';

final class QuizSessionState {
  const QuizSessionState({
    required this.attempt,
    required this.questions,
    required this.index,
    required this.answers,
    required this.finished,
    required this.deadline,
    this.questionShownAt,
    this.selectedChoice,
    this.shortAnswer = '',
  });

  final QuizAttempt attempt;
  final List<QuizQuestion> questions;
  final int index;
  final List<QuizAnswer> answers;
  final bool finished;
  final DateTime? deadline;
  final DateTime? questionShownAt;
  final String? selectedChoice;
  final String shortAnswer;

  QuizQuestion? get currentQuestion =>
      index >= 0 && index < questions.length ? questions[index] : null;

  int get remainingSeconds {
    final end = deadline;
    if (end == null) {
      return 0;
    }
    final seconds = end.difference(DateTime.now().toUtc()).inSeconds;
    return seconds < 0 ? 0 : seconds;
  }

  bool get timedOut {
    final end = deadline;
    if (end == null) {
      return false;
    }
    return !DateTime.now().toUtc().isBefore(end);
  }

  QuizSessionState copyWith({
    QuizAttempt? attempt,
    List<QuizQuestion>? questions,
    int? index,
    List<QuizAnswer>? answers,
    bool? finished,
    DateTime? deadline,
    bool clearDeadline = false,
    DateTime? questionShownAt,
    bool clearQuestionShownAt = false,
    String? selectedChoice,
    bool clearSelectedChoice = false,
    String? shortAnswer,
  }) {
    return QuizSessionState(
      attempt: attempt ?? this.attempt,
      questions: questions ?? this.questions,
      index: index ?? this.index,
      answers: answers ?? this.answers,
      finished: finished ?? this.finished,
      deadline: clearDeadline ? null : (deadline ?? this.deadline),
      questionShownAt: clearQuestionShownAt
          ? null
          : (questionShownAt ?? this.questionShownAt),
      selectedChoice: clearSelectedChoice
          ? null
          : (selectedChoice ?? this.selectedChoice),
      shortAnswer: shortAnswer ?? this.shortAnswer,
    );
  }
}

final quizSessionControllerProvider = AsyncNotifierProvider.autoDispose
    .family<QuizSessionController, QuizSessionState, String>(
      QuizSessionController.new,
    );

final class QuizSessionController extends AsyncNotifier<QuizSessionState> {
  QuizSessionController(this.attemptId);

  final String attemptId;
  Timer? _ticker;

  @override
  Future<QuizSessionState> build() async {
    final pendingStore = ref.read(pendingQuizSessionStoreProvider);
    ref.onDispose(() {
      _ticker?.cancel();
      pendingStore.clear(attemptId);
    });
    final quiz = ref.watch(quizRepositoryProvider);
    final pending = pendingStore.take(attemptId);
    if (pending != null) {
      _armTicker(pending.deadline);
      return QuizSessionState(
        attempt: pending.attempt,
        questions: pending.questions,
        index: 0,
        answers: const [],
        finished: false,
        deadline: pending.deadline,
        questionShownAt: ref.read(clockProvider).now(),
      );
    }
    final attempt = await quiz.findAttempt(attemptId);
    if (attempt == null) {
      throw const ValidationException(message: 'That quiz no longer exists.');
    }
    final summary = await quiz.loadSummary(attemptId);
    return QuizSessionState(
      attempt: summary.attempt,
      questions: const [],
      index: summary.answers.length,
      answers: summary.answers,
      finished: true,
      deadline: null,
    );
  }

  void selectChoice(String value) {
    final current = state.asData?.value;
    if (current == null || current.finished) {
      return;
    }
    state = AsyncData(current.copyWith(selectedChoice: value));
  }

  void setShortAnswer(String value) {
    final current = state.asData?.value;
    if (current == null || current.finished) {
      return;
    }
    state = AsyncData(current.copyWith(shortAnswer: value));
  }

  Future<void> submitCurrent() async {
    final current = state.asData?.value;
    if (current == null || current.finished) {
      return;
    }
    if (current.timedOut) {
      await finish(expired: true);
      return;
    }
    final question = current.currentQuestion;
    if (question == null) {
      await finish();
      return;
    }
    final given = question.type == QuizQuestionType.mcq
        ? current.selectedChoice
        : current.shortAnswer;
    if (question.type == QuizQuestionType.mcq &&
        (given == null || given.isEmpty)) {
      throw const ValidationException(message: 'Choose an answer.');
    }
    if (question.type == QuizQuestionType.shortAnswer &&
        (given == null || given.trim().isEmpty)) {
      throw const ValidationException(message: 'Type an answer.');
    }
    final shownAt = current.questionShownAt;
    final elapsed = shownAt == null
        ? null
        : ref.read(clockProvider).now().difference(shownAt).inMilliseconds;
    final answer = await ref
        .read(quizRepositoryProvider)
        .recordAnswer(
          attemptId: current.attempt.id,
          question: question,
          givenAnswer: given,
          elapsedMilliseconds: elapsed,
        );
    final nextAnswers = [...current.answers, answer];
    final nextIndex = current.index + 1;
    if (nextIndex >= current.questions.length) {
      await _complete(current: current, answers: nextAnswers);
      return;
    }
    state = AsyncData(
      current.copyWith(
        attempt: current.attempt.copyWith(
          correctCount: nextAnswers.where((item) => item.isCorrect).length,
        ),
        answers: nextAnswers,
        index: nextIndex,
        questionShownAt: ref.read(clockProvider).now(),
        clearSelectedChoice: true,
        shortAnswer: '',
      ),
    );
  }

  Future<void> finish({bool expired = false}) async {
    final current = state.asData?.value;
    if (current == null || current.finished) {
      return;
    }
    final quiz = ref.read(quizRepositoryProvider);
    var answers = current.answers;
    for (var i = current.index; i < current.questions.length; i++) {
      final recorded = await quiz.recordAnswer(
        attemptId: current.attempt.id,
        question: current.questions[i],
        givenAnswer: null,
      );
      answers = [...answers, recorded];
    }
    await _complete(current: current, answers: answers, expired: expired);
  }

  Future<void> _complete({
    required QuizSessionState current,
    required List<QuizAnswer> answers,
    bool expired = false,
  }) async {
    final completed = await ref
        .read(quizRepositoryProvider)
        .completeAttempt(current.attempt.id);
    _ticker?.cancel();
    unawaited(
      ref.read(analyticsClientProvider).track(
        AnalyticsEvent.quizCompleted,
        properties: {
          'correct': completed.correctCount,
          'count': completed.questionCount,
          'expired': expired,
        },
      ),
    );
    state = AsyncData(
      current.copyWith(
        attempt: completed,
        answers: answers,
        index: current.questions.length,
        finished: true,
        clearDeadline: true,
        clearQuestionShownAt: true,
        clearSelectedChoice: true,
        shortAnswer: '',
      ),
    );
  }

  void _armTicker(DateTime? deadline) {
    _ticker?.cancel();
    if (deadline == null) {
      return;
    }
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) async {
      final current = state.asData?.value;
      if (current == null || current.finished) {
        _ticker?.cancel();
        return;
      }
      if (current.timedOut) {
        await finish(expired: true);
        return;
      }
      state = AsyncData(current.copyWith());
    });
  }
}
