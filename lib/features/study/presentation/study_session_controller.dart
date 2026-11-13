import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/dependencies.dart';
import '../../../core/analytics/analytics_event.dart';
import '../../../core/errors/app_exception.dart';
import '../../flashcards/domain/flashcard.dart';
import '../../home/presentation/dashboard_controller.dart';
import '../domain/study_models.dart';

final class StudySessionState {
  const StudySessionState({
    required this.session,
    required this.queue,
    required this.index,
    required this.revealed,
    required this.finished,
    this.cardShownAt,
  });

  final StudySession session;
  final List<Flashcard> queue;
  final int index;
  final bool revealed;
  final bool finished;
  final DateTime? cardShownAt;

  Flashcard? get currentCard =>
      index >= 0 && index < queue.length ? queue[index] : null;

  int get remaining => (queue.length - index).clamp(0, queue.length);

  StudySessionState copyWith({
    StudySession? session,
    List<Flashcard>? queue,
    int? index,
    bool? revealed,
    bool? finished,
    DateTime? cardShownAt,
    bool clearCardShownAt = false,
  }) {
    return StudySessionState(
      session: session ?? this.session,
      queue: queue ?? this.queue,
      index: index ?? this.index,
      revealed: revealed ?? this.revealed,
      finished: finished ?? this.finished,
      cardShownAt: clearCardShownAt
          ? null
          : (cardShownAt ?? this.cardShownAt),
    );
  }
}

final studySessionControllerProvider = AsyncNotifierProvider.autoDispose
    .family<StudySessionController, StudySessionState, String?>(
      StudySessionController.new,
    );

final class StudySessionController
    extends AsyncNotifier<StudySessionState> {
  StudySessionController(this.deckId);

  final String? deckId;

  @override
  Future<StudySessionState> build() async {
    final now = ref.watch(clockProvider).now();
    final study = ref.watch(studyRepositoryProvider);
    final due = await study.loadDueCards(deckId: deckId, now: now);
    final session = await study.startSession(deckId: deckId);
    unawaited(
      ref
          .read(analyticsClientProvider)
          .track(AnalyticsEvent.studySessionStarted),
    );
    if (due.isEmpty) {
      final completed = await study.completeSession(session.id);
      return StudySessionState(
        session: completed,
        queue: const [],
        index: 0,
        revealed: false,
        finished: true,
      );
    }
    return StudySessionState(
      session: session,
      queue: due,
      index: 0,
      revealed: false,
      finished: false,
      cardShownAt: now,
    );
  }

  void reveal() {
    final current = state.asData?.value;
    if (current == null || current.finished || current.revealed) {
      return;
    }
    state = AsyncData(current.copyWith(revealed: true));
  }

  Future<void> grade(RecallGrade grade) async {
    final current = state.asData?.value;
    final card = current?.currentCard;
    if (current == null || card == null || current.finished) {
      return;
    }
    if (!current.revealed) {
      throw const ValidationException(
        message: 'Reveal the answer before grading.',
      );
    }

    final shownAt = current.cardShownAt;
    final now = ref.read(clockProvider).now();
    final elapsed = shownAt == null
        ? null
        : now.difference(shownAt).inMilliseconds;

    final graded = await ref
        .read(studyRepositoryProvider)
        .gradeCard(
          sessionId: current.session.id,
          cardId: card.id,
          grade: grade,
          elapsedMilliseconds: elapsed,
        );

    final nextIndex = current.index + 1;
    if (nextIndex >= current.queue.length) {
      final completed = await ref
          .read(studyRepositoryProvider)
          .completeSession(current.session.id);
      unawaited(
        ref
            .read(analyticsClientProvider)
            .track(AnalyticsEvent.studySessionCompleted),
      );
      ref.invalidate(dashboardControllerProvider);
      state = AsyncData(
        current.copyWith(
          session: completed,
          index: nextIndex,
          revealed: false,
          finished: true,
          clearCardShownAt: true,
        ),
      );
      return;
    }

    ref.invalidate(dashboardControllerProvider);
    state = AsyncData(
      current.copyWith(
        session: graded.session,
        index: nextIndex,
        revealed: false,
        cardShownAt: now,
      ),
    );
  }

  Future<StudySession> abandon() async {
    final current = state.asData?.value;
    if (current == null) {
      throw const ValidationException(
        message: 'That study session no longer exists.',
      );
    }
    final completed = await ref
        .read(studyRepositoryProvider)
        .completeSession(current.session.id);
    ref.invalidate(dashboardControllerProvider);
    return completed;
  }
}
