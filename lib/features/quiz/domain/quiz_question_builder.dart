import 'dart:math';

import '../../flashcards/domain/flashcard.dart';
import 'quiz_models.dart';

/// Builds exam-style questions from living flashcards.
///
/// MCQ needs at least one other distinct answer in the pool for distractors.
/// Cards that cannot form MCQ fall back to short answer.
final class QuizQuestionBuilder {
  QuizQuestionBuilder({Random? random}) : _random = random ?? Random();

  final Random _random;

  List<QuizQuestion> build({
    required List<Flashcard> cards,
    required int count,
    required QuizQuestionStyle style,
  }) {
    if (cards.isEmpty || count <= 0) {
      return const [];
    }
    final pool = List<Flashcard>.from(cards)..shuffle(_random);
    final selected = pool.take(count.clamp(1, pool.length)).toList();
    final answers = {
      for (final card in cards) card.id: card.answer,
    };
    return [
      for (var index = 0; index < selected.length; index++)
        _buildOne(
          card: selected[index],
          style: style,
          index: index,
          answerById: answers,
          allCards: cards,
        ),
    ];
  }

  QuizQuestion _buildOne({
    required Flashcard card,
    required QuizQuestionStyle style,
    required int index,
    required Map<String, String> answerById,
    required List<Flashcard> allCards,
  }) {
    final preferMcq = switch (style) {
      QuizQuestionStyle.mcq => true,
      QuizQuestionStyle.shortAnswer => false,
      QuizQuestionStyle.mixed => index.isEven,
    };
    if (preferMcq) {
      final choices = _mcqChoices(
        correct: card.answer,
        cardId: card.id,
        allCards: allCards,
      );
      if (choices.length >= 2) {
        return QuizQuestion(
          cardId: card.id,
          prompt: card.question,
          correctAnswer: card.answer,
          type: QuizQuestionType.mcq,
          choices: choices,
        );
      }
    }
    return QuizQuestion(
      cardId: card.id,
      prompt: card.question,
      correctAnswer: card.answer,
      type: QuizQuestionType.shortAnswer,
    );
  }

  List<String> _mcqChoices({
    required String correct,
    required String cardId,
    required List<Flashcard> allCards,
  }) {
    final distractors = <String>{};
    final normalizedCorrect = correct.trim().toLowerCase();
    final candidates = List<Flashcard>.from(allCards)..shuffle(_random);
    for (final candidate in candidates) {
      if (candidate.id == cardId) {
        continue;
      }
      final answer = candidate.answer.trim();
      if (answer.isEmpty) {
        continue;
      }
      if (answer.toLowerCase() == normalizedCorrect) {
        continue;
      }
      distractors.add(answer);
      if (distractors.length >= 3) {
        break;
      }
    }
    if (distractors.isEmpty) {
      return const [];
    }
    final choices = [correct.trim(), ...distractors]..shuffle(_random);
    return choices;
  }
}
