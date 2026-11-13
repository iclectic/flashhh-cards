import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/dependencies.dart';
import '../../../core/analytics/analytics_event.dart';
import '../../../core/errors/app_exception.dart';
import '../../../core/validation/field_limits.dart';
import '../../decks/presentation/deck_list_controller.dart';
import '../../home/presentation/dashboard_controller.dart';
import '../domain/flashcard.dart';

final deckCardsControllerProvider = AsyncNotifierProvider.autoDispose
    .family<DeckCardsController, List<Flashcard>, String>(
      DeckCardsController.new,
    );

final class DeckCardsController extends AsyncNotifier<List<Flashcard>> {
  DeckCardsController(this.deckId);

  final String deckId;
  String _searchText = '';

  String get searchText => _searchText;

  @override
  Future<List<Flashcard>> build() {
    return ref
        .watch(flashcardRepositoryProvider)
        .search(
          FlashcardQuery(
            deckId: deckId,
            text: _searchText.isEmpty ? null : _searchText,
            limit: FieldLimits.pageSize,
          ),
        );
  }

  Future<void> setSearchText(String value) async {
    _searchText = value.trim();
    ref.invalidateSelf();
    await future;
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }

  Future<Flashcard> create({
    required String question,
    required String answer,
    Difficulty? difficulty,
    List<String> tags = const [],
  }) async {
    final card = await ref
        .read(flashcardRepositoryProvider)
        .create(
          NewFlashcard(
            deckId: deckId,
            question: question,
            answer: answer,
            difficulty: difficulty,
            tags: tags,
          ),
        );
    unawaited(
      ref.read(analyticsClientProvider).track(AnalyticsEvent.flashcardCreated),
    );
    _invalidateRelated();
    return card;
  }

  Future<Flashcard> updateCard({
    required String id,
    required String question,
    required String answer,
    Difficulty? difficulty,
    List<String> tags = const [],
  }) async {
    final card = await ref
        .read(flashcardRepositoryProvider)
        .update(
          FlashcardUpdate(
            id: id,
            question: question,
            answer: answer,
            difficulty: difficulty,
            tags: tags,
          ),
        );
    _invalidateRelated();
    ref.invalidate(flashcardDetailControllerProvider(id));
    return card;
  }

  Future<void> deleteCard(String id) async {
    await ref.read(flashcardRepositoryProvider).delete(id);
    _invalidateRelated();
    ref.invalidate(flashcardDetailControllerProvider(id));
  }

  Future<Flashcard> duplicateCard(String id) async {
    final card = await ref.read(flashcardRepositoryProvider).duplicate(id);
    _invalidateRelated();
    return card;
  }

  void _invalidateRelated() {
    ref.invalidate(dashboardControllerProvider);
    ref.invalidate(deckDetailControllerProvider(deckId));
    ref.invalidate(deckListControllerProvider);
    ref.invalidateSelf();
  }
}

final flashcardDetailControllerProvider = AsyncNotifierProvider.autoDispose
    .family<FlashcardDetailController, Flashcard, String>(
      FlashcardDetailController.new,
    );

final class FlashcardDetailController extends AsyncNotifier<Flashcard> {
  FlashcardDetailController(this.cardId);

  final String cardId;

  @override
  Future<Flashcard> build() async {
    final card = await ref.watch(flashcardRepositoryProvider).findById(cardId);
    if (card == null) {
      throw const ValidationException(
        message: 'That flashcard no longer exists.',
      );
    }
    return card;
  }
}
