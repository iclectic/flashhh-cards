import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/app_routes.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/errors/app_exception.dart';
import '../../../core/widgets/empty_state_view.dart';
import '../../../core/widgets/error_state_view.dart';
import '../../../core/widgets/loading_view.dart';
import '../../../core/widgets/responsive_content.dart';
import '../../../core/widgets/stat_tile.dart';
import '../../study/domain/study_models.dart';
import 'dashboard_controller.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboard = ref.watch(dashboardControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flashhh'),
        actions: [
          IconButton(
            tooltip: 'Settings',
            onPressed: () => context.push(AppRoutes.settings),
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: switch (dashboard) {
        AsyncLoading() => const LoadingView(
          label: 'Loading your study summary',
        ),
        AsyncError(:final error) => ErrorStateView(
          message: failureFor(error).message,
          onRetry: () => ref.invalidate(dashboardControllerProvider),
        ),
        AsyncData(:final value) => _DashboardBody(snapshot: value),
      },
    );
  }
}

class _DashboardBody extends ConsumerWidget {
  const _DashboardBody({required this.snapshot});

  final DashboardSnapshot snapshot;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return RefreshIndicator(
          onRefresh: () =>
              ref.read(dashboardControllerProvider.notifier).refresh(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: ResponsiveContent(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Today',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      _StatGroup(snapshot: snapshot),
                      const SizedBox(height: AppSpacing.xl),
                      Text(
                        'Decks',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      if (snapshot.decks.isEmpty)
                        const EmptyStateView(
                          title: 'No decks yet',
                          message: 'When you add a deck, its progress will appear here.',
                          icon: Icons.library_books_outlined,
                        )
                      else
                        for (final deck in snapshot.decks) ...[
                          _DeckProgressTile(progress: deck),
                          const SizedBox(height: AppSpacing.sm),
                        ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _StatGroup extends StatelessWidget {
  const _StatGroup({required this.snapshot});

  final DashboardSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final tiles = [
          StatTile(
            label: 'Due today',
            value: '${snapshot.cardsDue}',
            icon: Icons.event_available_outlined,
          ),
          StatTile(
            label: 'Studied today',
            value: '${snapshot.cardsStudiedToday}',
            icon: Icons.school_outlined,
          ),
          StatTile(
            label: 'Day streak',
            value: '${snapshot.streak}',
            icon: Icons.local_fire_department_outlined,
          ),
        ];
        if (constraints.maxWidth < 600) {
          return Column(
            children: [
              for (final tile in tiles) ...[
                tile,
                const SizedBox(height: AppSpacing.sm),
              ],
            ],
          );
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final tile in tiles) ...[
              Expanded(child: tile),
              if (tile != tiles.last) const SizedBox(width: AppSpacing.sm),
            ],
          ],
        );
      },
    );
  }
}

class _DeckProgressTile extends StatelessWidget {
  const _DeckProgressTile({required this.progress});

  final DeckProgress progress;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final total = progress.totalCards;
    final reviewed = progress.reviewedCards;
    final fraction = total == 0 ? 0.0 : reviewed / total;
    final summary = total == 0
        ? 'No cards yet'
        : '$reviewed of $total reviewed';
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(progress.deckName, style: theme.textTheme.titleMedium),
            const SizedBox(height: AppSpacing.sm),
            Text(summary),
            const SizedBox(height: AppSpacing.sm),
            Semantics(
              label: '${progress.deckName}. $summary',
              value: '${(fraction * 100).round()} percent',
              child: LinearProgressIndicator(value: fraction),
            ),
          ],
        ),
      ),
    );
  }
}
