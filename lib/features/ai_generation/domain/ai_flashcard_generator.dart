import 'ai_models.dart';

/// Asks the backend to draft flashcards.
///
/// Implementations must call the application backend. They must not embed
/// a provider credential or send the document to an AI vendor directly.
abstract interface class AiFlashcardGenerator {
  Future<GeneratedFlashcardValidationResult> generate(
    FlashcardGenerationRequest request,
  );
}

/// Backend document-text extraction.
///
/// Ordinary PDF text extraction lives on the server. When extraction returns
/// too little text, the server can route the document through OCR without
/// changing this contract.
abstract interface class DocumentTextExtractor {
  Future<ExtractedDocumentText> extract(DocumentExtractionRequest request);
}

final class DocumentExtractionRequest {
  const DocumentExtractionRequest({
    required this.documentImportId,
    required this.fileName,
    required this.byteSize,
  });

  final String documentImportId;
  final String fileName;
  final int byteSize;
}

final class ExtractedDocumentText {
  const ExtractedDocumentText({
    required this.characterCount,
    required this.sections,
    required this.usedOcr,
  });

  final int characterCount;
  final List<TextSection> sections;
  final bool usedOcr;
}
