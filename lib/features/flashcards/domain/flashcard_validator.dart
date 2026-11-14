import '../../../core/errors/app_exception.dart';
import '../../../core/validation/field_limits.dart';
import '../../../core/validation/text_rules.dart';
import '../../study/domain/cloze_parser.dart';
import 'flashcard.dart';

final class ValidatedFlashcardContent {
  const ValidatedFlashcardContent({
    required this.question,
    required this.answer,
    required this.tags,
    required this.cardType,
  });

  final String question;
  final String answer;
  final List<String> tags;
  final FlashcardCardType cardType;
}

abstract final class FlashcardValidator {
  static ValidatedFlashcardContent content({
    required String question,
    required String answer,
    required List<String> tags,
    FlashcardCardType cardType = FlashcardCardType.basic,
  }) {
    final normalizedQuestion = normalizeWhitespace(question);
    var normalizedAnswer = answer.trim();
    if (normalizedQuestion.isEmpty) {
      throw const ValidationException(message: 'Enter a question.');
    }

    if (cardType == FlashcardCardType.cloze) {
      if (!ClozeParser.hasMarkup(normalizedQuestion)) {
        throw const ValidationException(
          message: 'Cloze cards need {{c1::hidden text}} in the question.',
        );
      }
      if (ClozeParser.deletionCount(normalizedQuestion) < 1) {
        throw const ValidationException(
          message: 'Cloze cards need at least one blank.',
        );
      }
      if (normalizedAnswer.isEmpty) {
        normalizedAnswer = ClozeParser.expectedAnswer(normalizedQuestion);
      }
    }

    if (normalizedAnswer.isEmpty) {
      throw const ValidationException(message: 'Enter an answer.');
    }
    if (normalizedQuestion.length > FieldLimits.question) {
      throw const ValidationException(
        message: 'Questions can be up to 500 characters.',
      );
    }
    if (normalizedAnswer.length > FieldLimits.answer) {
      throw const ValidationException(
        message: 'Answers can be up to 2000 characters.',
      );
    }
    return ValidatedFlashcardContent(
      question: normalizedQuestion,
      answer: normalizedAnswer,
      tags: normalizeTags(tags),
      cardType: cardType,
    );
  }

  static List<String> normalizeTags(List<String> tags) {
    final seen = <String>{};
    final result = <String>[];
    for (final raw in tags) {
      final tag = normalizeTag(raw);
      if (tag.isEmpty) {
        continue;
      }
      if (tag.length > FieldLimits.tag) {
        throw const ValidationException(
          message: 'Tags can be up to 30 characters.',
        );
      }
      if (seen.add(tag)) {
        result.add(tag);
      }
    }
    if (result.length > FieldLimits.maxTags) {
      throw const ValidationException(
        message: 'A flashcard can have up to 8 tags.',
      );
    }
    return result;
  }

  static void page({required int limit, required int offset}) {
    if (limit < 1 || limit > FieldLimits.maxPageSize) {
      throw const ValidationException(
        message: 'Card pages must contain between 1 and 200 cards.',
      );
    }
    if (offset < 0) {
      throw const ValidationException(message: 'The card page is invalid.');
    }
  }
}
