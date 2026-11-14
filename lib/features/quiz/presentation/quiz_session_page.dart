import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/app_routes.dart';
import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/errors/app_exception.dart';
import '../../../core/widgets/error_state_view.dart';
import '../../../core/widgets/loading_view.dart';
import '../../../core/widgets/responsive_content.dart';
import '../domain/quiz_models.dart';
import 'quiz_session_controller.dart';

class QuizSessionPage extends ConsumerWidget {
  const QuizSessionPage({required this.attemptId, super.key});

  final String attemptId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(quizSessionControllerProvider(attemptId));
    return switch (session) {
      AsyncLoading() => Scaffold(
        appBar: AppBar(title: const Text('Quiz')),
        body: const LoadingView(label: 'Preparing your quiz'),
      ),
      AsyncError(:final error) => Scaffold(
        appBar: AppBar(title: const Text('Quiz')),
        body: ErrorStateView(
          message: failureFor(error).message,
          onRetry: () =>
              ref.invalidate(quizSessionControllerProvider(attemptId)),
        ),
      ),
      AsyncData(:final value) when value.finished =>
        _QuizSummaryView(state: value),
      AsyncData(:final value) => _QuizActiveView(
        attemptId: attemptId,
        state: value,
      ),
    };
  }
}

class _QuizActiveView extends ConsumerWidget {
  const _QuizActiveView({required this.attemptId, required this.state});

  final String attemptId;
  final QuizSessionState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final question = state.currentQuestion;
    if (question == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Quiz')),
        body: const LoadingView(label: 'Finishing quiz'),
      );
    }
    final progressLabel = '${state.index + 1} of ${state.questions.length}';
    final timedLabel = state.deadline == null
        ? null
        : _formatSeconds(state.remainingSeconds);
    return Scaffold(
      appBar: AppBar(
        title: Text(progressLabel),
        actions: [
          if (timedLabel != null)
            Padding(
              padding: const EdgeInsets.only(right: AppSpacing.md),
              child: Center(
                child: Text(
                  timedLabel,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
        ],
        leading: IconButton(
          tooltip: 'End quiz',
          icon: const Icon(Icons.close),
          onPressed: () =>
              ref.read(quizSessionControllerProvider(attemptId).notifier).finish(),
        ),
      ),
      body: ResponsiveContent(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Semantics(
                label:
                    'Progress: question ${state.index + 1} of ${state.questions.length}',
                value: state.questions.isEmpty
                    ? '0%'
                    : '${((state.index / state.questions.length) * 100).round()}%',
                child: LinearProgressIndicator(
                  value: state.questions.isEmpty
                      ? 0
                      : state.index / state.questions.length,
                ),
              ),
              if (timedLabel != null) ...[
                const SizedBox(height: AppSpacing.sm),
                Semantics(
                  liveRegion: true,
                  label: 'Time remaining $timedLabel',
                  child: const SizedBox.shrink(),
                ),
              ],
              const SizedBox(height: AppSpacing.lg),
              Text(
                question.type == QuizQuestionType.mcq
                    ? 'Multiple choice'
                    : 'Short answer',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Expanded(
                child: Material(
                  color: Theme.of(context).colorScheme.surfaceContainerLow,
                  borderRadius: AppRadius.borderLg,
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: SingleChildScrollView(
                      child: Text(
                        question.prompt,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              if (question.type == QuizQuestionType.mcq)
                for (final choice in question.choices) ...[
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.all(AppSpacing.md),
                      backgroundColor: state.selectedChoice == choice
                          ? Theme.of(context).colorScheme.primaryContainer
                          : null,
                    ),
                    onPressed: () => ref
                        .read(quizSessionControllerProvider(attemptId).notifier)
                        .selectChoice(choice),
                    child: Text(choice),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                ]
              else
                TextField(
                  key: ValueKey('short-${state.index}'),
                  decoration: const InputDecoration(
                    labelText: 'Your answer',
                    hintText: 'Type what you remember',
                  ),
                  textInputAction: TextInputAction.done,
                  onChanged: (value) => ref
                      .read(quizSessionControllerProvider(attemptId).notifier)
                      .setShortAnswer(value),
                  onSubmitted: (_) => _submit(context, ref),
                ),
              const SizedBox(height: AppSpacing.md),
              FilledButton(
                onPressed: () => _submit(context, ref),
                child: Text(
                  state.index + 1 >= state.questions.length
                      ? 'Finish quiz'
                      : 'Submit answer',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submit(BuildContext context, WidgetRef ref) async {
    try {
      await ref
          .read(quizSessionControllerProvider(attemptId).notifier)
          .submitCurrent();
    } on AppException catch (error) {
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(failureFor(error).message)));
    }
  }

  String _formatSeconds(int total) {
    final minutes = total ~/ 60;
    final seconds = total % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}

class _QuizSummaryView extends StatelessWidget {
  const _QuizSummaryView({required this.state});

  final QuizSessionState state;

  @override
  Widget build(BuildContext context) {
    final attempt = state.attempt;
    final score =
        '${attempt.correctCount}/${attempt.questionCount} correct';
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz results')),
      body: ResponsiveContent(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            Text(score, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: AppSpacing.sm),
            Text(
              attempt.timedSeconds == null
                  ? 'Untimed quiz'
                  : 'Timed quiz (${attempt.timedSeconds! ~/ 60} min)',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: AppSpacing.lg),
            for (final answer in state.answers) ...[
              Card(
                child: ListTile(
                  leading: Icon(
                    answer.isCorrect
                        ? Icons.check_circle_outline
                        : Icons.cancel_outlined,
                    color: answer.isCorrect
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.error,
                  ),
                  title: Text(answer.prompt),
                  subtitle: Text(
                    answer.isCorrect
                        ? 'Your answer: ${answer.givenAnswer ?? '—'}'
                        : 'Yours: ${answer.givenAnswer ?? '(blank)'} · '
                            'Correct: ${answer.correctAnswer}',
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
            ],
            const SizedBox(height: AppSpacing.md),
            FilledButton(
              onPressed: () => context.go(AppRoutes.quiz),
              child: const Text('Back to quiz setup'),
            ),
            const SizedBox(height: AppSpacing.sm),
            OutlinedButton(
              onPressed: () => context.go(AppRoutes.home),
              child: const Text('Home'),
            ),
          ],
        ),
      ),
    );
  }
}
