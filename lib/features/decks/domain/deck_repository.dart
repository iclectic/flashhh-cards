import 'deck.dart';

abstract interface class DeckRepository {
  Future<List<Deck>> listDecks({required String ownerId});

  Future<Deck?> findById(String id);

  Future<Deck> createDeck({
    required String ownerId,
    required String name,
    required String description,
  });

  Future<Deck> updateDeck({
    required String id,
    required String name,
    required String description,
  });

  Future<void> deleteDeck(String id);
}
