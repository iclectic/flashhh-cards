import '../../../app/configuration/app_config.dart';
import '../../../core/errors/app_exception.dart';
import '../../../core/validation/field_limits.dart';
import 'ai_flashcard_generator.dart';
import 'ai_models.dart';
import 'heuristic_flashcard_generator.dart';
import 'pending_document_bytes.dart';

/// Narrow upload surface so the pipeline does not depend on Dio types.
abstract interface class DocumentUploadExtractor {
  Future<ExtractedDocumentText> extractUpload({
    required DocumentExtractionRequest request,
    required List<int> pdfBytes,
  });
}

/// Coordinates extract → generate → validated drafts.
final class GenerationPipeline {
  GenerationPipeline({
    required AiFlashcardGenerator generator,
    required HeuristicAiFlashcardGenerator fallbackGenerator,
    required PendingDocumentBytesStore pendingBytes,
    required AppConfig config,
    DocumentUploadExtractor? uploader,
  }) : _generator = generator,
       _fallbackGenerator = fallbackGenerator,
       _pendingBytes = pendingBytes,
       _config = config,
       _uploader = uploader;

  final AiFlashcardGenerator _generator;
  final HeuristicAiFlashcardGenerator _fallbackGenerator;
  final PendingDocumentBytesStore _pendingBytes;
  final AppConfig _config;
  final DocumentUploadExtractor? _uploader;

  Future<GeneratedFlashcardValidationResult> generateFromNotes({
    required String documentImportId,
    required String notes,
    required int desiredCount,
    required GenerationDifficulty difficulty,
    required QuestionStyle questionStyle,
  }) {
    final sections = chunkNotes(notes);
    if (sections.isEmpty) {
      throw const ValidationException(
        message: 'Paste some notes before generating cards.',
      );
    }
    return _generate(
      FlashcardGenerationRequest(
        documentImportId: documentImportId,
        sections: sections,
        desiredCount: desiredCount.clamp(1, _config.maxGeneratedCards),
        difficulty: difficulty,
        questionStyle: questionStyle,
      ),
    );
  }

  Future<GeneratedFlashcardValidationResult> generateFromImport({
    required DocumentImport document,
    required int desiredCount,
    required GenerationDifficulty difficulty,
    required QuestionStyle questionStyle,
  }) async {
    final bytes = _pendingBytes.peek(document.id);
    if (bytes == null) {
      throw const DocumentException(
        message:
            'This PDF is no longer available for generation. Choose it again, or paste notes.',
      );
    }
    final uploader = _uploader;
    if (uploader == null) {
      throw const DocumentException(
        message:
            'Connect the Flashhh API to extract text from PDFs, or paste notes instead.',
      );
    }

    final extracted = await uploader.extractUpload(
      request: DocumentExtractionRequest(
        documentImportId: document.id,
        fileName: document.fileName,
        byteSize: document.byteSize,
      ),
      pdfBytes: bytes,
    );

    return _generate(
      FlashcardGenerationRequest(
        documentImportId: document.id,
        sections: extracted.sections,
        desiredCount: desiredCount.clamp(1, _config.maxGeneratedCards),
        difficulty: difficulty,
        questionStyle: questionStyle,
      ),
    );
  }

  Future<GeneratedFlashcardValidationResult> _generate(
    FlashcardGenerationRequest request,
  ) async {
    try {
      return await _generator.generate(request);
    } on AppException {
      if (identical(_generator, _fallbackGenerator)) {
        rethrow;
      }
      return _fallbackGenerator.generate(request);
    } catch (_) {
      return _fallbackGenerator.generate(request);
    }
  }
}

int defaultDesiredCount(AppConfig config) =>
    config.maxGeneratedCards.clamp(1, FieldLimits.pageSize);
