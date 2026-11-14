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
import '../domain/study_card_face.dart';
import '../domain/study_models.dart';
import 'study_session_controller.dart';

class StudySessionPage extends ConsumerWidget {
  const StudySessionPage({required this.args, super.key});

  final StudySessionArgs args;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(studySessionControllerProvider(args));
    final title = args.mode == StudySessionMode.cram ? 'Cram' : 'Study';
    return switch (session) {
      AsyncLoading() => Scaffold(
        appBar: AppBar(title: Text(title)),
        body: const LoadingView(label: 'Preparing your session'),
      ),
      AsyncError(:final error) => Scaffold(
        appBar: AppBar(title: Text(title)),
        body: ErrorStateView(
          message: failureFor(error).message,
          onRetry: () =>
              ref.invalidate(studySessionControllerProvider(args)),
        ),
      ),
      AsyncData(:final value) when value.finished =>
        _StudySummaryView(state: value),
      AsyncData(:final value) => _StudyActiveView(state: value),
    };
  }
}

class _StudyActiveView extends ConsumerWidget {
  const _StudyActiveView({required this.state});

  final StudySessionState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final args = state.args;
    final card = state.currentCard;
    final title = args.mode == StudySessionMode.cram ? 'Cram' : 'Study';
    if (card == null) {
      return Scaffold(
        appBar: AppBar(title: Text(title)),
        body: EmptyStateView(
          title: args.mode == StudySessionMode.cram
              ? 'Nothing to cram'
              : 'Nothing to study',
          message: args.mode == StudySessionMode.cram
              ? 'Add cards to this deck first.'
              : 'There are no due cards right now.',
          icon: Icons.school_outlined,
        ),
      );
    }
    final theme = Theme.of(context);
    final progressLabel = '${state.index + 1} of ${state.queue.length}';
    final faceText = state.revealed
        ? StudyCardFace.reveal(card)
        : StudyCardFace.prompt(card);
    final faceLabel = state.revealed
        ? StudyCardFace.revealLabel(card)
        : StudyCardFace.promptLabel(card);

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
              Semantics(
                label: 'Progress: card ${state.index + 1} of ${state.queue.length}',
                value: state.queue.isEmpty
                    ? '0%'
                    : '${((state.index / state.queue.length) * 100).round()}%',
                child: LinearProgressIndicator(
                  value: state.queue.isEmpty
                      ? 0
                      : state.index / state.queue.length,
                ),
              ),
              if (args.mode == StudySessionMode.cram) ...[
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'Cram mode — schedule stays unchanged',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
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
                                studySessionControllerProvider(args).notifier,
                              )
                              .reveal(),
                    child: Semantics(
                      button: !state.revealed,
                      label: state.revealed
                          ? '$faceLabel: $faceText'
                          : 'Show answer. $faceLabel: $faceText',
                      child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            faceLabel,
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: theme.colorScheme.primary,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Text(
                                faceText,
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
                          if (state.typedMatch != null) ...[
                            const SizedBox(height: AppSpacing.md),
                            Text(
                              state.typedMatch!
                                  ? 'Looks right'
                                  : 'Not quite — check the answer',
                              textAlign: TextAlign.center,
                              style: theme.textTheme.titleSmall?.copyWith(
                                color: state.typedMatch!
                                    ? theme.colorScheme.primary
                                    : theme.colorScheme.error,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    ),
                  ),
                ),
              ),
              if (args.typedAnswer && !state.revealed) ...[
                const SizedBox(height: AppSpacing.md),
                TextField(
                  key: ValueKey('typed-${card.id}-${state.index}'),
                  textCapitalization: TextCapitalization.sentences,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    labelText: 'Type your answer',
                    hintText: 'Optional — check before revealing',
                  ),
                  onChanged: (value) => ref
                      .read(studySessionControllerProvider(args).notifier)
                      .setTypedDraft(value),
                  onSubmitted: (_) => ref
                      .read(studySessionControllerProvider(args).notifier)
                      .checkTypedAnswer(),
                ),
              ],
              const SizedBox(height: AppSpacing.lg),
              if (!state.revealed)
                Row(
                  children: [
                    if (args.typedAnswer) ...[
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => ref
                              .read(
                                studySessionControllerProvider(args).notifier,
                              )
                              .checkTypedAnswer(),
                          child: const Text('Check'),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                    ],
                    Expanded(
                      child: FilledButton(
                        onPressed: () => ref
                            .read(
                              studySessionControllerProvider(args).notifier,
                            )
                            .reveal(),
                        child: const Text('Show answer'),
                      ),
                    ),
                  ],
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
          .read(studySessionControllerProvider(state.args).notifier)
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
          .read(studySessionControllerProvider(state.args).notifier)
          .abandon();
      if (!context.mounted) {
        return;
      }
      final deckId = state.args.deckId;
      if (deckId != null) {
        context.go(AppRoutes.deck(deckId));
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
  const _StudySummaryView({required this.state});

  final StudySessionState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = state.session;
    final deckId = state.args.deckId;
    final theme = Theme.of(context);
    final isCram = state.args.mode == StudySessionMode.cram;
    return Scaffold(
      appBar: AppBar(
        title: Text(isCram ? 'Cram complete' : 'Session complete'),
      ),
      body: ResponsiveContent(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            Text(
              session.cardsReviewed == 0
                  ? (isCram ? 'Nothing to cram' : 'Nothing due right now')
                  : 'Nice work',
              style: theme.textTheme.headlineSmall,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              session.cardsReviewed == 0
                  ? (isCram
                        ? 'Add cards to this deck, then come back.'
                        : 'Come back when cards are due, or add more to this deck.')
                  : 'You reviewed ${session.cardsReviewed} '
                        '${session.cardsReviewed == 1 ? 'card' : 'cards'}'
                        '${isCram ? ' (schedule unchanged)' : ''}.',
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
                  context.go(AppRoutes.deck(deckId));
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
