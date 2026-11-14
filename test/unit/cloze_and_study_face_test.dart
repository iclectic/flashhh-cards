import 'package:flashhh_cards/features/flashcards/domain/flashcard.dart';
import 'package:flashhh_cards/features/flashcards/domain/flashcard_validator.dart';
import 'package:flashhh_cards/features/study/domain/cloze_parser.dart';
import 'package:flashhh_cards/features/study/domain/study_card_face.dart';
import 'package:flashhh_cards/core/errors/app_exception.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ClozeParser', () {
    test('blanks, reveals, and extracts expected answers', () {
      const question = 'The {{c1::capital}} of France is {{c2::Paris}}.';
      expect(ClozeParser.hasMarkup(question), isTrue);
      expect(
        ClozeParser.prompt(question),
        'The […] of France is […].',
      );
      expect(
        ClozeParser.revealed(question),
        'The capital of France is Paris.',
      );
      expect(ClozeParser.expectedAnswer(question), 'capital; Paris');
      expect(ClozeParser.deletionCount(question), 2);
    });
  });

  group('StudyCardFace', () {
    final created = DateTime.utc(2026, 6, 15);

    Flashcard card({
      required FlashcardCardType type,
      String question = 'What is X?',
      String answer = 'Y',
    }) {
      return Flashcard(
        id: 'c1',
        deckId: 'd1',
        question: question,
        answer: answer,
        createdAt: created,
        updatedAt: created,
        source: FlashcardSource.manual,
        cardType: type,
      );
    }

    test('basic and reverse swap faces', () {
      final basic = card(type: FlashcardCardType.basic);
      expect(StudyCardFace.prompt(basic), 'What is X?');
      expect(StudyCardFace.reveal(basic), 'Y');
      expect(StudyCardFace.typedExpected(basic), 'Y');

      final reverse = card(type: FlashcardCardType.reverse);
      expect(StudyCardFace.prompt(reverse), 'Y');
      expect(StudyCardFace.reveal(reverse), 'What is X?');
      expect(StudyCardFace.typedExpected(reverse), 'What is X?');
    });

    test('cloze uses markup for prompt and typed expected', () {
      final cloze = card(
        type: FlashcardCardType.cloze,
        question: 'The {{c1::mitochondria}} is the powerhouse.',
        answer: 'mitochondria',
      );
      expect(
        StudyCardFace.prompt(cloze),
        'The […] is the powerhouse.',
      );
      expect(
        StudyCardFace.reveal(cloze),
        'The mitochondria is the powerhouse.',
      );
      expect(StudyCardFace.typedExpected(cloze), 'mitochondria');
    });
  });

  test('cloze validator derives answer from markup', () {
    final content = FlashcardValidator.content(
      question: 'Hello {{c1::world}}',
      answer: '',
      tags: const [],
      cardType: FlashcardCardType.cloze,
    );
    expect(content.answer, 'world');
    expect(content.cardType, FlashcardCardType.cloze);

    expect(
      () => FlashcardValidator.content(
        question: 'No blanks here',
        answer: 'x',
        tags: const [],
        cardType: FlashcardCardType.cloze,
      ),
      throwsA(isA<ValidationException>()),
    );
  });
}
