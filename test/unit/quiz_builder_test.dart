import 'dart:math';

import 'package:flashhh_cards/features/flashcards/domain/flashcard.dart';
import 'package:flashhh_cards/features/quiz/domain/quiz_answer_grader.dart';
import 'package:flashhh_cards/features/quiz/domain/quiz_models.dart';
import 'package:flashhh_cards/features/quiz/domain/quiz_question_builder.dart';
import 'package:flutter_test/flutter_test.dart';

Flashcard _card(String id, String answer) {
  final now = DateTime.utc(2026, 6, 15, 12);
  return Flashcard(
    id: id,
    deckId: 'deck-1',
    question: 'Q $id?',
    answer: answer,
    createdAt: now,
    updatedAt: now,
    source: FlashcardSource.manual,
  );
}

void main() {
  test('grader normalizes case and punctuation', () {
    expect(
      QuizAnswerGrader.matches(
        given: '  Consistency, Availability! ',
        expected: 'consistency availability',
      ),
      isTrue,
    );
    expect(
      QuizAnswerGrader.matches(given: 'wrong', expected: 'right'),
      isFalse,
    );
  });

  test('builder creates MCQ with distractors when possible', () {
    final builder = QuizQuestionBuilder(random: Random(1));
    final questions = builder.build(
      cards: [
        _card('1', 'Alpha'),
        _card('2', 'Beta'),
        _card('3', 'Gamma'),
        _card('4', 'Delta'),
      ],
      count: 2,
      style: QuizQuestionStyle.mcq,
    );
    expect(questions, hasLength(2));
    expect(questions.every((q) => q.type == QuizQuestionType.mcq), isTrue);
    expect(questions.first.choices, contains(questions.first.correctAnswer));
    expect(questions.first.choices.length, greaterThanOrEqualTo(2));
  });

  test('builder falls back to short answer without distractors', () {
    final builder = QuizQuestionBuilder(random: Random(2));
    final questions = builder.build(
      cards: [_card('1', 'Only answer')],
      count: 1,
      style: QuizQuestionStyle.mcq,
    );
    expect(questions.single.type, QuizQuestionType.shortAnswer);
  });
}
