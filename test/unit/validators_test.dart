import 'package:flashhh_cards/core/errors/app_exception.dart';
import 'package:flashhh_cards/features/ai_generation/domain/generated_flashcard_validator.dart';
import 'package:flashhh_cards/features/ai_generation/domain/import_policy.dart';
import 'package:flashhh_cards/features/decks/domain/deck_validator.dart';
import 'package:flashhh_cards/features/flashcards/domain/flashcard.dart';
import 'package:flashhh_cards/features/flashcards/domain/flashcard_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('deck and card validators reject empty and oversized text', () {
    expect(
      () => DeckValidator.name('   '),
      throwsA(isA<ValidationException>()),
    );
    expect(DeckValidator.name('  Biology  '), 'Biology');
    expect(
      () => DeckValidator.description('x' * 501),
      throwsA(isA<ValidationException>()),
    );

    final content = FlashcardValidator.content(
      question: '  What is a cell? ',
      answer: ' The basic unit of life. ',
      tags: [' Biology ', 'biology', ''],
    );
    expect(content.question, 'What is a cell?');
    expect(content.answer, 'The basic unit of life.');
    expect(content.tags, ['biology']);
    expect(
      () => FlashcardValidator.content(
        question: '',
        answer: 'answer',
        tags: const [],
      ),
      throwsA(isA<ValidationException>()),
    );
  });

  test('AI output keeps valid cards and drops malformed ones', () {
    const validator = GeneratedFlashcardValidator();
    final result = validator.validate({
      'flashcards': [
        {
          'question': ' What is encapsulation? ',
          'answer': 'Bundling data and behaviour while hiding internal state.',
          'difficulty': 'medium',
          'sourceReference': 'Section 2',
          'ignored': 'not stored',
        },
        {'question': 'What is encapsulation?', 'answer': 'Duplicate'},
        {'question': '', 'answer': 'Missing question'},
        {'question': 'Too long', 'answer': ''},
        {'question': 12, 'answer': 'Not text'},
        {
          'question': 'What is inheritance?',
          'answer': 'A type can reuse and extend another type.',
          'difficulty': 'impossible',
        },
      ],
    }, maxCards: 10);

    expect(result.accepted, hasLength(1));
    expect(result.accepted.single.question, 'What is encapsulation?');
    expect(result.accepted.single.difficulty, Difficulty.medium);
    expect(result.accepted.single.sourceReference, 'Section 2');
    expect(result.rejectedCount, 5);
  });

  test('malformed AI payloads are rejected entirely', () {
    const validator = GeneratedFlashcardValidator();
    expect(
      () => validator.validate('free text', maxCards: 5),
      throwsA(isA<AiGenerationException>()),
    );
    expect(
      () => validator.validate({'cards': <Object>[]}, maxCards: 5),
      throwsA(isA<AiGenerationException>()),
    );
  });

  test(
    'document policy rejects unsupported types, empty files, and oversized files',
    () {
      expect(
        () => DocumentImportPolicy.validateNew(
          fileName: 'notes.docx',
          byteSize: 10,
          maxBytes: 100,
        ),
        throwsA(isA<DocumentException>()),
      );
      expect(
        () => DocumentImportPolicy.validateNew(
          fileName: '../secret.pdf',
          byteSize: 10,
          maxBytes: 100,
        ),
        throwsA(isA<DocumentException>()),
      );
      expect(
        () => DocumentImportPolicy.validateNew(
          fileName: 'notes.pdf',
          byteSize: 0,
          maxBytes: 100,
        ),
        throwsA(isA<DocumentException>()),
      );
      expect(
        () => DocumentImportPolicy.validateNew(
          fileName: 'notes.pdf',
          byteSize: 101,
          maxBytes: 100,
        ),
        throwsA(isA<DocumentException>()),
      );
      DocumentImportPolicy.validateNew(
        fileName: ' notes.PDF ',
        byteSize: 20,
        maxBytes: 100,
      );
      DocumentImportPolicy.validateNew(
        fileName: 'lecture-notes.txt',
        byteSize: 20,
        maxBytes: 100,
      );
    },
  );
}
