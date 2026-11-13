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
import '../domain/insight_models.dart';
import 'insights_controller.dart';

class InsightsPage extends ConsumerWidget {
  const InsightsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final insights = ref.watch(insightsControllerProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Insights')),
      body: switch (insights) {
        AsyncLoading() => const LoadingView(label: 'Loading insights'),
        AsyncError(:final error) => ErrorStateView(
          message: failureFor(error).message,
          onRetry: () => ref.invalidate(insightsControllerProvider),
        ),
        AsyncData(:final value) => _InsightsBody(snapshot: value),
      },
    );
  }
}

class _InsightsBody extends ConsumerWidget {
  const _InsightsBody({required this.snapshot});

  final InsightsSnapshot snapshot;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return RefreshIndicator(
      onRefresh: () => ref.read(insightsControllerProvider.notifier).refresh(),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          ResponsiveContent(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'What to study next',
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'Based on due cards, recent misses, and quiz results on this '
                  'device.',
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: AppSpacing.md),
                if (snapshot.nextActions.isEmpty)
                  const EmptyStateView(
                    title: 'Nothing queued',
                    message: 'Study or quiz to unlock recommendations.',
                    icon: Icons.insights_outlined,
                  )
                else
                  for (final action in snapshot.nextActions) ...[
                    _NextActionTile(action: action),
                    const SizedBox(height: AppSpacing.sm),
                  ],
                const SizedBox(height: AppSpacing.lg),
                Text('Study calendar', style: theme.textTheme.titleLarge),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'Last ${snapshot.calendar.length} days · streak ${snapshot.streak}',
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: AppSpacing.md),
                _CalendarStrip(days: snapshot.calendar),
                const SizedBox(height: AppSpacing.xl),
                Text('Retention', style: theme.textTheme.titleLarge),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'Daily accuracy from reviews (Good/Easy) and correct quiz '
                  'answers.',
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: AppSpacing.md),
                _RetentionBars(points: snapshot.retention),
                const SizedBox(height: AppSpacing.xl),
                Text('Weak tags', style: theme.textTheme.titleLarge),
                const SizedBox(height: AppSpacing.sm),
                if (snapshot.weakTags.isEmpty)
                  Text(
                    'No tagged misses yet. Add tags on cards to see weak topics.',
                    style: theme.textTheme.bodyMedium,
                  )
                else
                  for (final tag in snapshot.weakTags)
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.label_outline),
                      title: Text(tag.tag),
                      subtitle: Text(
                        '${tag.misses} misses · ${(tag.accuracy * 100).round()}% accuracy',
                      ),
                      trailing: Text('${tag.attempts}'),
                    ),
                const SizedBox(height: AppSpacing.xl),
                Text('Weak cards', style: theme.textTheme.titleLarge),
                const SizedBox(height: AppSpacing.sm),
                if (snapshot.weakCards.isEmpty)
                  Text(
                    'No recent misses. Keep studying to surface hard cards.',
                    style: theme.textTheme.bodyMedium,
                  )
                else
                  for (final card in snapshot.weakCards)
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.warning_amber_outlined),
                      title: Text(
                        card.prompt,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        '${card.deckName} · ${card.misses} misses',
                      ),
                      onTap: () => context.push(AppRoutes.deck(card.deckId)),
                    ),
                const SizedBox(height: AppSpacing.xxl),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NextActionTile extends StatelessWidget {
  const _NextActionTile({required this.action});

  final StudyNextAction action;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(_iconFor(action.kind)),
        title: Text(action.title),
        subtitle: Text(action.subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => _open(context, action),
      ),
    );
  }

  IconData _iconFor(StudyNextKind kind) {
    return switch (kind) {
      StudyNextKind.studyDue => Icons.school_outlined,
      StudyNextKind.reviewWeakTag => Icons.label_outline,
      StudyNextKind.takeQuiz => Icons.quiz_outlined,
      StudyNextKind.addCards => Icons.add,
    };
  }

  void _open(BuildContext context, StudyNextAction action) {
    switch (action.kind) {
      case StudyNextKind.studyDue:
        context.push(AppRoutes.study);
      case StudyNextKind.reviewWeakTag:
        context.push(AppRoutes.study);
      case StudyNextKind.takeQuiz:
        context.push(AppRoutes.quiz);
      case StudyNextKind.addCards:
        context.push(AppRoutes.decks);
    }
  }
}

class _CalendarStrip extends StatelessWidget {
  const _CalendarStrip({required this.days});

  final List<StudyDayActivity> days;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 72,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          for (final day in days)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1),
                child: Tooltip(
                  message:
                      '${_label(day.day)} · '
                      '${day.reviewCount + day.quizAnswerCount} activities',
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: _colorFor(theme, day),
                      borderRadius: AppRadius.borderSm,
                    ),
                    child: const SizedBox.expand(),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Color _colorFor(ThemeData theme, StudyDayActivity day) {
    final total = day.reviewCount + day.quizAnswerCount;
    if (total <= 0) {
      return theme.colorScheme.surfaceContainerHighest;
    }
    if (total == 1) {
      return theme.colorScheme.primary.withValues(alpha: 0.35);
    }
    if (total <= 3) {
      return theme.colorScheme.primary.withValues(alpha: 0.6);
    }
    return theme.colorScheme.primary;
  }

  String _label(DateTime day) {
    return '${day.year}-${day.month.toString().padLeft(2, '0')}-'
        '${day.day.toString().padLeft(2, '0')}';
  }
}

class _RetentionBars extends StatelessWidget {
  const _RetentionBars({required this.points});

  final List<RetentionPoint> points;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final recent = points.length <= 14
        ? points
        : points.sublist(points.length - 14);
    if (recent.every((point) => point.attempts == 0)) {
      return Text(
        'No graded activity in this window yet.',
        style: theme.textTheme.bodyMedium,
      );
    }
    return SizedBox(
      height: 120,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          for (final point in recent)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Tooltip(
                  message: point.attempts == 0
                      ? 'No attempts'
                      : '${(point.accuracy * 100).round()}% · '
                          '${point.successes}/${point.attempts}',
                  child: FractionallySizedBox(
                    heightFactor: point.attempts == 0
                        ? 0.08
                        : point.accuracy.clamp(0.08, 1),
                    alignment: Alignment.bottomCenter,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: point.attempts == 0
                            ? theme.colorScheme.surfaceContainerHighest
                            : theme.colorScheme.tertiary,
                        borderRadius: AppRadius.borderSm,
                      ),
                      child: const SizedBox.expand(),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
