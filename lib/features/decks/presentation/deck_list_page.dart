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
import '../domain/deck.dart';
import 'deck_list_controller.dart';

class DeckListPage extends ConsumerWidget {
  const DeckListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final decks = ref.watch(deckListControllerProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Decks')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppRoutes.deckNew),
        icon: const Icon(Icons.add),
        label: const Text('New deck'),
      ),
      body: switch (decks) {
        AsyncLoading() => const LoadingView(label: 'Loading decks'),
        AsyncError(:final error) => ErrorStateView(
          message: failureFor(error).message,
          onRetry: () => ref.invalidate(deckListControllerProvider),
        ),
        AsyncData(:final value) => _DeckListBody(decks: value),
      },
    );
  }
}

class _DeckListBody extends ConsumerWidget {
  const _DeckListBody({required this.decks});

  final List<Deck> decks;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (decks.isEmpty) {
      return Center(
        child: EmptyStateView(
          title: 'No decks yet',
          message: 'Create a deck to start collecting flashcards.',
          icon: Icons.library_books_outlined,
          actionLabel: 'Create deck',
          onAction: () => context.push(AppRoutes.deckNew),
        ),
      );
    }
    return RefreshIndicator(
      onRefresh: () => ref.read(deckListControllerProvider.notifier).refresh(),
      child: ResponsiveContent(
        child: ListView.separated(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.md,
            AppSpacing.md,
            AppSpacing.md,
            88,
          ),
          itemCount: decks.length,
          separatorBuilder: (context, index) =>
              const SizedBox(height: AppSpacing.sm),
          itemBuilder: (context, index) {
            final deck = decks[index];
            final subtitle = deck.cardCount == 1
                ? '1 card'
                : '${deck.cardCount} cards';
            return Card(
              child: ListTile(
                title: Text(deck.name),
                subtitle: Text(
                  deck.description.isEmpty ? subtitle : '$subtitle · ${deck.description}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push(AppRoutes.deck(deck.id)),
              ),
            );
          },
        ),
      ),
    );
  }
}
