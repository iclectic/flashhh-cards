import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/dependencies.dart';
import '../../../core/analytics/analytics_event.dart';
import '../../../core/errors/app_exception.dart';
import '../../home/presentation/dashboard_controller.dart';
import '../domain/deck.dart';

final deckListControllerProvider =
    AsyncNotifierProvider<DeckListController, List<Deck>>(
      DeckListController.new,
    );

final class DeckListController extends AsyncNotifier<List<Deck>> {
  @override
  Future<List<Deck>> build() async {
    final account = await ref.watch(localAccountProvider.future);
    return ref.watch(deckRepositoryProvider).listDecks(ownerId: account.id);
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }

  Future<Deck> createDeck({
    required String name,
    required String description,
  }) async {
    final account = await ref.read(localAccountProvider.future);
    final deck = await ref
        .read(deckRepositoryProvider)
        .createDeck(
          ownerId: account.id,
          name: name,
          description: description,
        );
    unawaited(
      ref.read(analyticsClientProvider).track(AnalyticsEvent.deckCreated),
    );
    ref.invalidate(dashboardControllerProvider);
    ref.invalidateSelf();
    return deck;
  }

  Future<Deck> updateDeck({
    required String id,
    required String name,
    required String description,
  }) async {
    final deck = await ref
        .read(deckRepositoryProvider)
        .updateDeck(id: id, name: name, description: description);
    ref.invalidate(dashboardControllerProvider);
    ref.invalidate(deckDetailControllerProvider(id));
    ref.invalidateSelf();
    return deck;
  }

  Future<void> deleteDeck(String id) async {
    await ref.read(deckRepositoryProvider).deleteDeck(id);
    ref.invalidate(dashboardControllerProvider);
    ref.invalidate(deckDetailControllerProvider(id));
    ref.invalidateSelf();
  }
}

final deckDetailControllerProvider = AsyncNotifierProvider.autoDispose
    .family<DeckDetailController, Deck, String>(DeckDetailController.new);

final class DeckDetailController extends AsyncNotifier<Deck> {
  DeckDetailController(this.deckId);

  final String deckId;

  @override
  Future<Deck> build() async {
    final deck = await ref.watch(deckRepositoryProvider).findById(deckId);
    if (deck == null) {
      throw const ValidationException(message: 'That deck no longer exists.');
    }
    return deck;
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }
}
