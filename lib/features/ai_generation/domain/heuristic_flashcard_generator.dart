import '../../../core/validation/field_limits.dart';
import '../../flashcards/domain/flashcard.dart';
import 'ai_flashcard_generator.dart';
import 'ai_models.dart';
import 'generated_flashcard_validator.dart';

/// Local structured drafts when the backend is unreachable or unused in tests.
final class HeuristicAiFlashcardGenerator implements AiFlashcardGenerator {
  HeuristicAiFlashcardGenerator({
    this.maxCards = FieldLimits.pageSize,
    GeneratedFlashcardValidator validator = const GeneratedFlashcardValidator(),
  }) : _validator = validator;

  final int maxCards;
  final GeneratedFlashcardValidator _validator;

  @override
  Future<GeneratedFlashcardValidationResult> generate(
    FlashcardGenerationRequest request,
  ) async {
    final flashcards = <Map<String, Object?>>[];
    final seen = <String>{};
    final limit = request.desiredCount.clamp(1, maxCards);

    for (final section in request.sections) {
      for (final pair in _sentencePairs(section.text)) {
        if (flashcards.length >= limit) {
          break;
        }
        final conceptual =
            request.questionStyle == QuestionStyle.conceptualUnderstanding ||
            (request.questionStyle == QuestionStyle.mixed &&
                flashcards.length.isOdd);
        final question = conceptual
            ? 'Explain the idea behind: “${_clip(pair.lead, 160)}”'
            : 'What does this note establish? “${_clip(pair.lead, 160)}”';
        final key = question.toLowerCase();
        if (!seen.add(key)) {
          continue;
        }
        flashcards.add({
          'question': question,
          'answer': _clip(pair.support, FieldLimits.answer),
          'difficulty': _difficultyName(request.difficulty, flashcards.length),
          'sourceReference': section.reference,
        });
      }
      if (flashcards.length >= limit) {
        break;
      }
    }

    if (flashcards.isEmpty) {
      for (final (index, section) in request.sections.indexed) {
        if (flashcards.length >= limit) {
          break;
        }
        final text = section.text.trim();
        if (text.length < 20) {
          continue;
        }
        flashcards.add({
          'question': 'Summarize ${section.reference}',
          'answer': _clip(text, FieldLimits.answer),
          'difficulty': _difficultyName(request.difficulty, index),
          'sourceReference': section.reference,
        });
      }
    }

    return _validator.validate({'flashcards': flashcards}, maxCards: maxCards);
  }

  List<({String lead, String support})> _sentencePairs(String text) {
    final sentences = text
        .split(RegExp(r'(?<=[.!?])\s+'))
        .map((part) => part.trim())
        .where((part) => part.length >= 40)
        .toList();
    final pairs = <({String lead, String support})>[];
    for (var i = 0; i < sentences.length; i++) {
      pairs.add((
        lead: sentences[i],
        support: i + 1 < sentences.length ? sentences[i + 1] : sentences[i],
      ));
    }
    return pairs;
  }

  String _difficultyName(GenerationDifficulty difficulty, int index) {
    return switch (difficulty) {
      GenerationDifficulty.beginner => Difficulty.easy.name,
      GenerationDifficulty.advanced =>
        index.isEven ? Difficulty.hard.name : Difficulty.medium.name,
      GenerationDifficulty.intermediate => switch (index % 3) {
        0 => Difficulty.hard.name,
        1 => Difficulty.medium.name,
        _ => Difficulty.easy.name,
      },
    };
  }

  String _clip(String value, int max) {
    final trimmed = value.trim();
    if (trimmed.length <= max) {
      return trimmed;
    }
    return trimmed.substring(0, max);
  }
}

/// Chunks pasted notes or extracted PDF text into overlapping study sections.
List<TextSection> chunkNotes(String text, {int maxLen = 900}) {
  final cleaned = text.replaceAll('\r', '').trim();
  if (cleaned.isEmpty) {
    return const [];
  }
  final paragraphs = cleaned
      .split(RegExp(r'\n{2,}'))
      .map((part) => part.replaceAll(RegExp(r'\s+'), ' ').trim())
      .where((part) => part.isNotEmpty)
      .toList();
  final chunks = <String>[];
  var current = '';
  for (final paragraph in paragraphs) {
    final candidate = current.isEmpty ? paragraph : '$current $paragraph';
    if (candidate.length > maxLen && current.isNotEmpty) {
      chunks.add(current.trim());
      current = paragraph;
    } else {
      current = candidate;
    }
  }
  if (current.trim().isNotEmpty) {
    chunks.add(current.trim());
  }
  return [
    for (var i = 0; i < chunks.length; i++)
      TextSection(reference: 'section-${i + 1}', text: chunks[i]),
  ];
}
