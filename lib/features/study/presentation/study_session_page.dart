import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/app_routes.dart';
import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/errors/app_exception.dart';
import '../../../core/widgets/empty_state_view.dart';
import '../../../core/widgets/error_state_view.dart';
import '../../../core/widgets/loading_view.dart';
import '../../../core/widgets/responsive_content.dart';
import '../../home/presentation/dashboard_controller.dart';
import '../domain/study_models.dart';
import 'study_session_controller.dart';

class StudySessionPage extends ConsumerWidget {
  const StudySessionPage({this.deckId, super.key});

  final String? deckId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(studySessionControllerProvider(deckId));
    return switch (session) {
      AsyncLoading() => Scaffold(
        appBar: AppBar(title: const Text('Study')),
        body: const LoadingView(label: 'Preparing your session'),
      ),
      AsyncError(:final error) => Scaffold(
        appBar: AppBar(title: const Text('Study')),
        body: ErrorStateView(
          message: failureFor(error).message,
          onRetry: () =>
              ref.invalidate(studySessionControllerProvider(deckId)),
        ),
      ),
      AsyncData(:final value) when value.finished =>
        _StudySummaryView(state: value, deckId: deckId),
      AsyncData(:final value) => _StudyActiveView(
        state: value,
        deckId: deckId,
      ),
    };
  }
}

class _StudyActiveView extends ConsumerWidget {
  const _StudyActiveView({required this.state, required this.deckId});

  final StudySessionState state;
  final String? deckId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final card = state.currentCard;
    if (card == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Study')),
        body: const EmptyStateView(
          title: 'Nothing to study',
          message: 'There are no due cards right now.',
          icon: Icons.school_outlined,
        ),
      );
    }
    final theme = Theme.of(context);
    final progressLabel =
        '${state.index + 1} of ${state.queue.length}';
    return Scaffold(
      appBar: AppBar(
        title: Text(progressLabel),
        leading: IconButton(
          tooltip: 'End session',
          icon: const Icon(Icons.close),
          onPressed: () => _end(context, ref),
        ),
      ),
      body: ResponsiveContent(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LinearProgressIndicator(
                value: state.queue.isEmpty
                    ? 0
                    : state.index / state.queue.length,
              ),
              const SizedBox(height: AppSpacing.lg),
              Expanded(
                child: Material(
                  color: theme.colorScheme.surfaceContainerLow,
                  borderRadius: AppRadius.borderLg,
                  child: InkWell(
                    borderRadius: AppRadius.borderLg,
                    onTap: state.revealed
                        ? null
                        : () => ref
                              .read(
                                studySessionControllerProvider(
                                  deckId,
                                ).notifier,
                              )
                              .reveal(),
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            state.revealed ? 'Answer' : 'Question',
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: theme.colorScheme.primary,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Text(
                                state.revealed
                                    ? card.answer
                                    : card.question,
                                style: theme.textTheme.headlineSmall,
                              ),
                            ),
                          ),
                          if (!state.revealed)
                            Text(
                              'Tap to reveal',
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              if (!state.revealed)
                FilledButton(
                  onPressed: () => ref
                      .read(
                        studySessionControllerProvider(deckId).notifier,
                      )
                      .reveal(),
                  child: const Text('Show answer'),
                )
              else
                _GradeRow(
                  onGrade: (grade) => _grade(context, ref, grade),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _grade(
    BuildContext context,
    WidgetRef ref,
    RecallGrade grade,
  ) async {
    try {
      await ref
          .read(studySessionControllerProvider(deckId).notifier)
          .grade(grade);
    } on AppException catch (error) {
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(failureFor(error).message)));
    }
  }

  Future<void> _end(BuildContext context, WidgetRef ref) async {
    try {
      await ref
          .read(studySessionControllerProvider(deckId).notifier)
          .abandon();
      if (!context.mounted) {
        return;
      }
      if (deckId != null) {
        context.go(AppRoutes.deck(deckId!));
      } else {
        context.go(AppRoutes.home);
      }
    } on AppException catch (error) {
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(failureFor(error).message)));
    }
  }
}

class _GradeRow extends StatelessWidget {
  const _GradeRow({required this.onGrade});

  final ValueChanged<RecallGrade> onGrade;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final entry in const [
          (RecallGrade.again, 'Again'),
          (RecallGrade.hard, 'Hard'),
          (RecallGrade.good, 'Good'),
          (RecallGrade.easy, 'Easy'),
        ]) ...[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: entry.$1 == RecallGrade.good ||
                      entry.$1 == RecallGrade.easy
                  ? FilledButton(
                      onPressed: () => onGrade(entry.$1),
                      child: Text(entry.$2),
                    )
                  : OutlinedButton(
                      onPressed: () => onGrade(entry.$1),
                      child: Text(entry.$2),
                    ),
            ),
          ),
        ],
      ],
    );
  }
}

class _StudySummaryView extends ConsumerWidget {
  const _StudySummaryView({required this.state, required this.deckId});

  final StudySessionState state;
  final String? deckId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = state.session;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Session complete')),
      body: ResponsiveContent(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            Text(
              session.cardsReviewed == 0
                  ? 'Nothing due right now'
                  : 'Nice work',
              style: theme.textTheme.headlineSmall,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              session.cardsReviewed == 0
                  ? 'Come back when cards are due, or add more to this deck.'
                  : 'You reviewed ${session.cardsReviewed} '
                        '${session.cardsReviewed == 1 ? 'card' : 'cards'}.',
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: AppSpacing.xl),
            _SummaryStat(label: 'Again', value: session.againCount),
            _SummaryStat(label: 'Hard', value: session.hardCount),
            _SummaryStat(label: 'Good', value: session.goodCount),
            _SummaryStat(label: 'Easy', value: session.easyCount),
            const SizedBox(height: AppSpacing.xl),
            FilledButton(
              onPressed: () {
                ref.invalidate(dashboardControllerProvider);
                if (deckId != null) {
                  context.go(AppRoutes.deck(deckId!));
                } else {
                  context.go(AppRoutes.home);
                }
              },
              child: const Text('Done'),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryStat extends StatelessWidget {
  const _SummaryStat({required this.label, required this.value});

  final String label;
  final int value;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(label),
      trailing: Text(
        '$value',
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
