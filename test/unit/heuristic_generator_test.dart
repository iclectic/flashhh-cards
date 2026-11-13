import 'package:flashhh_cards/features/ai_generation/domain/ai_models.dart';
import 'package:flashhh_cards/features/ai_generation/domain/heuristic_flashcard_generator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('heuristic generator drafts cards from note sections', () async {
    final generator = HeuristicAiFlashcardGenerator(maxCards: 8);
    final sections = chunkNotes(
      'Caching stores expensive results for reuse. '
      'A cache hit returns a stored value without recomputation. '
      'A cache miss loads data from the source of truth. '
      'TTL policies expire entries after a fixed duration. '
      'Eviction strategies remove cold entries under memory pressure.',
    );
    final result = await generator.generate(
      FlashcardGenerationRequest(
        documentImportId: 'doc-1',
        sections: sections,
        desiredCount: 4,
        difficulty: GenerationDifficulty.intermediate,
        questionStyle: QuestionStyle.mixed,
      ),
    );
    expect(result.accepted, isNotEmpty);
    expect(result.accepted.first.question, isNotEmpty);
    expect(result.accepted.first.answer, isNotEmpty);
  });

  test('chunkNotes splits paragraphs into sections', () {
    final sections = chunkNotes('Alpha paragraph.\n\nBeta paragraph with more text.');
    expect(sections.length, greaterThanOrEqualTo(1));
    expect(sections.first.reference, 'section-1');
  });
}
