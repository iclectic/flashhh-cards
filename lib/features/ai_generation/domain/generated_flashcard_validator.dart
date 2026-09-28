import '../../../core/errors/app_exception.dart';
import '../../../core/validation/field_limits.dart';
import '../../../core/validation/text_rules.dart';
import '../../flashcards/domain/flashcard.dart';
import 'ai_models.dart';

/// Treats model output as untrusted input.
///
/// Malformed cards are dropped. A payload that is not the expected object
/// is rejected entirely so the app never saves free-form text as cards.
final class GeneratedFlashcardValidator {
  const GeneratedFlashcardValidator();

  GeneratedFlashcardValidationResult validate(
    Object? payload, {
    required int maxCards,
  }) {
    if (payload is! Map) {
      throw const AiGenerationException(
        message:
            'The draft cards could not be read. Try generating them again.',
      );
    }
    final rawCards = payload['flashcards'];
    if (rawCards is! List) {
      throw const AiGenerationException(
        message:
            'The draft cards could not be read. Try generating them again.',
      );
    }

    final accepted = <GeneratedFlashcardDraft>[];
    final seen = <String>{};
    var rejected = 0;
    for (final item in rawCards) {
      if (accepted.length >= maxCards) {
        rejected += 1;
        continue;
      }
      final draft = _card(item);
      if (draft == null) {
        rejected += 1;
        continue;
      }
      final key = normalizeWhitespace(draft.question).toLowerCase();
      if (!seen.add(key)) {
        rejected += 1;
        continue;
      }
      accepted.add(draft);
    }
    return GeneratedFlashcardValidationResult(
      accepted: accepted,
      rejectedCount: rejected,
    );
  }

  GeneratedFlashcardDraft? _card(Object? item) {
    if (item is! Map) {
      return null;
    }
    final question = item['question'];
    final answer = item['answer'];
    if (question is! String || answer is! String) {
      return null;
    }
    final normalizedQuestion = normalizeWhitespace(question);
    final normalizedAnswer = answer.trim();
    if (normalizedQuestion.isEmpty || normalizedAnswer.isEmpty) {
      return null;
    }
    if (normalizedQuestion.length > FieldLimits.question ||
        normalizedAnswer.length > FieldLimits.answer) {
      return null;
    }
    final difficulty = _difficulty(item['difficulty']);
    if (item.containsKey('difficulty') &&
        item['difficulty'] != null &&
        difficulty == null) {
      return null;
    }
    final reference = item['sourceReference'];
    String? sourceReference;
    if (reference != null) {
      if (reference is! String) {
        return null;
      }
      sourceReference = normalizeWhitespace(reference);
      if (sourceReference.length > FieldLimits.sourceReference) {
        return null;
      }
      if (sourceReference.isEmpty) {
        sourceReference = null;
      }
    }
    return GeneratedFlashcardDraft(
      question: normalizedQuestion,
      answer: normalizedAnswer,
      difficulty: difficulty,
      sourceReference: sourceReference,
    );
  }

  Difficulty? _difficulty(Object? value) {
    if (value is! String) {
      return null;
    }
    for (final difficulty in Difficulty.values) {
      if (difficulty.name == value) {
        return difficulty;
      }
    }
    return null;
  }
}
