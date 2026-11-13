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

class _DeckDetailBody extends ConsumerWidget {
  const _DeckDetailBody({required this.deck});

  final Deck deck;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final cardLabel = deck.cardCount == 1
        ? '1 card'
        : '${deck.cardCount} cards';
    return Scaffold(
      appBar: AppBar(
        title: Text(deck.name),
        actions: [
          IconButton(
            tooltip: 'Edit deck',
            onPressed: () => context.push(AppRoutes.deckEdit(deck.id)),
            icon: const Icon(Icons.edit_outlined),
          ),
          IconButton(
            tooltip: 'Delete deck',
            onPressed: () => _delete(context, ref),
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
      body: ResponsiveContent(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
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
            const SizedBox(height: AppSpacing.xl),
            EmptyStateView(
              title: deck.cardCount == 0 ? 'No cards yet' : 'Cards coming next',
              message: deck.cardCount == 0
                  ? 'Card editing lands in the next phase. For now you can rename or delete this deck.'
                  : 'This deck has $cardLabel. Opening and editing them arrives with the card editor.',
              icon: Icons.style_outlined,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _delete(BuildContext context, WidgetRef ref) async {
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
