import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/app_routes.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/errors/app_exception.dart';
import '../../../core/widgets/confirm_dialog.dart';
import '../../../core/widgets/empty_state_view.dart';
import '../../../core/widgets/error_state_view.dart';
import '../../../core/widgets/loading_view.dart';
import '../../../core/widgets/responsive_content.dart';
import '../../flashcards/domain/flashcard.dart';
import '../../flashcards/presentation/deck_cards_controller.dart';
import '../domain/deck.dart';
import 'deck_list_controller.dart';

class DeckDetailPage extends ConsumerWidget {
  const DeckDetailPage({required this.deckId, super.key});

  final String deckId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(deckDetailControllerProvider(deckId));
    return switch (detail) {
      AsyncLoading() => Scaffold(
        appBar: AppBar(title: const Text('Deck')),
        body: const LoadingView(label: 'Loading deck'),
      ),
      AsyncError(:final error) => Scaffold(
        appBar: AppBar(title: const Text('Deck')),
        body: ErrorStateView(
          message: failureFor(error).message,
          onRetry: () => ref.invalidate(deckDetailControllerProvider(deckId)),
        ),
      ),
      AsyncData(:final value) => _DeckDetailBody(deck: value),
    };
  }
}

class _DeckDetailBody extends ConsumerStatefulWidget {
  const _DeckDetailBody({required this.deck});

  final Deck deck;

  @override
  ConsumerState<_DeckDetailBody> createState() => _DeckDetailBodyState();
}

class _DeckDetailBodyState extends ConsumerState<_DeckDetailBody> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Deck get deck => widget.deck;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardsAsync = ref.watch(deckCardsControllerProvider(deck.id));
    final cardLabel = deck.cardCount == 1
        ? '1 card'
        : '${deck.cardCount} cards';

    return Scaffold(
      appBar: AppBar(
        title: Text(deck.name),
        actions: [
          if (deck.cardCount > 0) ...[
            IconButton(
              tooltip: 'Quiz deck',
              onPressed: () => context.push(AppRoutes.quizDeck(deck.id)),
              icon: const Icon(Icons.quiz_outlined),
            ),
            IconButton(
              tooltip: 'Study deck',
              onPressed: () => context.push(AppRoutes.studyDeck(deck.id)),
              icon: const Icon(Icons.school_outlined),
            ),
          ],
          IconButton(
            tooltip: 'Edit deck',
            onPressed: () => context.push(AppRoutes.deckEdit(deck.id)),
            icon: const Icon(Icons.edit_outlined),
          ),
          IconButton(
            tooltip: 'Delete deck',
            onPressed: () => _deleteDeck(context),
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppRoutes.cardNew(deck.id)),
        icon: const Icon(Icons.add),
        label: const Text('Add card'),
      ),
      body: ResponsiveContent(
        child: RefreshIndicator(
          onRefresh: () async {
            await ref
                .read(deckDetailControllerProvider(deck.id).notifier)
                .refresh();
            await ref
                .read(deckCardsControllerProvider(deck.id).notifier)
                .refresh();
          },
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.md,
                  AppSpacing.md,
                  AppSpacing.md,
                  0,
                ),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    Text(deck.name, style: theme.textTheme.headlineSmall),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      cardLabel,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    if (deck.description.isNotEmpty) ...[
                      const SizedBox(height: AppSpacing.md),
                      Text(deck.description, style: theme.textTheme.bodyLarge),
                    ],
                    if (deck.cardCount > 0) ...[
                      const SizedBox(height: AppSpacing.md),
                      FilledButton.icon(
                        onPressed: () =>
                            context.push(AppRoutes.studyDeck(deck.id)),
                        icon: const Icon(Icons.school_outlined),
                        label: const Text('Study deck'),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      OutlinedButton.icon(
                        onPressed: () =>
                            context.push(AppRoutes.quizDeck(deck.id)),
                        icon: const Icon(Icons.quiz_outlined),
                        label: const Text('Quiz this deck'),
                      ),
                    ],
                    const SizedBox(height: AppSpacing.lg),
                    TextField(
                      controller: _searchController,
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                        labelText: 'Search cards',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: _searchController.text.isEmpty
                            ? null
                            : IconButton(
                                tooltip: 'Clear search',
                                onPressed: () {
                                  _searchController.clear();
                                  ref
                                      .read(
                                        deckCardsControllerProvider(
                                          deck.id,
                                        ).notifier,
                                      )
                                      .setSearchText('');
                                  setState(() {});
                                },
                                icon: const Icon(Icons.clear),
                              ),
                      ),
                      onChanged: (_) => setState(() {}),
                      onSubmitted: (value) {
                        ref
                            .read(
                              deckCardsControllerProvider(deck.id).notifier,
                            )
                            .setSearchText(value);
                      },
                    ),
                    const SizedBox(height: AppSpacing.md),
                  ]),
                ),
              ),
              ...switch (cardsAsync) {
                AsyncLoading() => [
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: LoadingView(label: 'Loading cards'),
                  ),
                ],
                AsyncError(:final error) => [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: ErrorStateView(
                      message: failureFor(error).message,
                      onRetry: () => ref.invalidate(
                        deckCardsControllerProvider(deck.id),
                      ),
                    ),
                  ),
                ],
                AsyncData(:final value) when value.isEmpty => [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: EmptyStateView(
                      title: _searchController.text.trim().isEmpty
                          ? 'No cards yet'
                          : 'No matching cards',
                      message: _searchController.text.trim().isEmpty
                          ? 'Add a question and answer to start this deck.'
                          : 'Try a different search, or clear the filter.',
                      icon: Icons.style_outlined,
                      actionLabel: _searchController.text.trim().isEmpty
                          ? 'Add card'
                          : null,
                      onAction: _searchController.text.trim().isEmpty
                          ? () => context.push(AppRoutes.cardNew(deck.id))
                          : null,
                    ),
                  ),
                ],
                AsyncData(:final value) => [
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.md,
                      0,
                      AppSpacing.md,
                      96,
                    ),
                    sliver: SliverList.separated(
                      itemCount: value.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: AppSpacing.sm),
                      itemBuilder: (context, index) {
                        return _CardTile(
                          deckId: deck.id,
                          card: value[index],
                        );
                      },
                    ),
                  ),
                ],
              },
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _deleteDeck(BuildContext context) async {
    final confirmed = await showConfirmDialog(
      context: context,
      title: 'Delete this deck?',
      message:
          '“${deck.name}” and its cards will be removed from this device. You can create a new deck anytime.',
      confirmLabel: 'Delete',
      destructive: true,
    );
    if (!confirmed) {
      return;
    }
    try {
      await ref.read(deckListControllerProvider.notifier).deleteDeck(deck.id);
      if (!context.mounted) {
        return;
      }
      context.go(AppRoutes.home);
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

class _CardTile extends ConsumerWidget {
  const _CardTile({required this.deckId, required this.card});

  final String deckId;
  final Flashcard card;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final meta = <String>[
      if (card.difficulty != null) card.difficulty!.name,
      if (card.tags.isNotEmpty) card.tags.join(', '),
    ].join(' · ');
    return Card(
      child: ListTile(
        title: Text(card.question, maxLines: 2, overflow: TextOverflow.ellipsis),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSpacing.xs),
            Text(
              card.answer,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            if (meta.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.xs),
              Text(meta, style: theme.textTheme.labelMedium),
            ],
          ],
        ),
        isThreeLine: true,
        trailing: PopupMenuButton<_CardAction>(
          tooltip: 'Card actions',
          onSelected: (action) => _handle(context, ref, action),
          itemBuilder: (context) => const [
            PopupMenuItem(value: _CardAction.edit, child: Text('Edit')),
            PopupMenuItem(
              value: _CardAction.duplicate,
              child: Text('Duplicate'),
            ),
            PopupMenuItem(value: _CardAction.delete, child: Text('Delete')),
          ],
        ),
        onTap: () => context.push(AppRoutes.cardEdit(deckId, card.id)),
      ),
    );
  }

  Future<void> _handle(
    BuildContext context,
    WidgetRef ref,
    _CardAction action,
  ) async {
    final cards = ref.read(deckCardsControllerProvider(deckId).notifier);
    switch (action) {
      case _CardAction.edit:
        context.push(AppRoutes.cardEdit(deckId, card.id));
      case _CardAction.duplicate:
        try {
          await cards.duplicateCard(card.id);
          if (!context.mounted) {
            return;
          }
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Card duplicated.')));
        } on AppException catch (error) {
          if (!context.mounted) {
            return;
          }
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(failureFor(error).message)));
        }
      case _CardAction.delete:
        final confirmed = await showConfirmDialog(
          context: context,
          title: 'Delete this card?',
          message: 'This question will be removed from the deck.',
          confirmLabel: 'Delete',
          destructive: true,
        );
        if (!confirmed) {
          return;
        }
        try {
          await cards.deleteCard(card.id);
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
}

enum _CardAction { edit, duplicate, delete }
