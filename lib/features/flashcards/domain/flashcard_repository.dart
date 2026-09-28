import 'flashcard.dart';

abstract interface class FlashcardRepository {
  Future<List<Flashcard>> search(FlashcardQuery query);

  Future<Flashcard?> findById(String id);

  Future<Flashcard> create(NewFlashcard draft);

  Future<Flashcard> update(FlashcardUpdate update);

  Future<void> delete(String id);

  Future<Flashcard> move({
    required String id,
    required String destinationDeckId,
  });

  Future<Flashcard> duplicate(String id);
}
