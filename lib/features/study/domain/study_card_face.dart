import '../../flashcards/domain/flashcard.dart';
import 'cloze_parser.dart';

/// Prompt / reveal / typed-expected text for a card during study.
abstract final class StudyCardFace {
  static String prompt(Flashcard card) {
    return switch (card.cardType) {
      FlashcardCardType.basic => card.question,
      FlashcardCardType.reverse => card.answer,
      FlashcardCardType.cloze => ClozeParser.prompt(card.question),
    };
  }

  static String reveal(Flashcard card) {
    return switch (card.cardType) {
      FlashcardCardType.basic => card.answer,
      FlashcardCardType.reverse => card.question,
      FlashcardCardType.cloze => ClozeParser.revealed(card.question),
    };
  }

  static String typedExpected(Flashcard card) {
    return switch (card.cardType) {
      FlashcardCardType.basic => card.answer,
      FlashcardCardType.reverse => card.question,
      FlashcardCardType.cloze => ClozeParser.expectedAnswer(card.question),
    };
  }

  static String promptLabel(Flashcard card) {
    return switch (card.cardType) {
      FlashcardCardType.basic => 'Question',
      FlashcardCardType.reverse => 'Answer first',
      FlashcardCardType.cloze => 'Fill the blank',
    };
  }

  static String revealLabel(Flashcard card) {
    return switch (card.cardType) {
      FlashcardCardType.basic => 'Answer',
      FlashcardCardType.reverse => 'Question',
      FlashcardCardType.cloze => 'Answer',
    };
  }
}
