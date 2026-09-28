import 'package:freezed_annotation/freezed_annotation.dart';

import '../../flashcards/domain/flashcard.dart';

part 'ai_models.freezed.dart';
part 'ai_models.g.dart';

@JsonEnum(fieldRename: FieldRename.snake)
enum GenerationDifficulty { beginner, intermediate, advanced }

@JsonEnum(fieldRename: FieldRename.snake)
enum QuestionStyle { factualRecall, conceptualUnderstanding, mixed }

@JsonEnum(fieldRename: FieldRename.snake)
enum DocumentImportStatus {
  selected,
  validating,
  extracting,
  readyForGeneration,
  generating,
  readyForReview,
  saved,
  failed,
  discarded,
}

enum GenerationStatus { started, completed, failed }

@freezed
abstract class DocumentImport with _$DocumentImport {
  const factory DocumentImport({
    required String id,
    required String fileName,
    required int byteSize,
    String? contentHash,
    int? pageCount,
    int? textCharacterCount,
    required DocumentImportStatus status,
    String? errorMessage,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? discardedAt,
  }) = _DocumentImport;

  factory DocumentImport.fromJson(Map<String, dynamic> json) =>
      _$DocumentImportFromJson(json);
}

@freezed
abstract class GenerationUsageRecord with _$GenerationUsageRecord {
  const factory GenerationUsageRecord({
    required String id,
    String? documentImportId,
    required DateTime createdAt,
    required GenerationStatus status,
    int? documentBytes,
    int? promptTokens,
    int? completionTokens,
    int? cardCount,
    double? estimatedCostUsd,
    String? failureCode,
  }) = _GenerationUsageRecord;

  factory GenerationUsageRecord.fromJson(Map<String, dynamic> json) =>
      _$GenerationUsageRecordFromJson(json);
}

final class TextSection {
  const TextSection({required this.reference, required this.text});

  final String reference;
  final String text;
}

final class FlashcardGenerationRequest {
  const FlashcardGenerationRequest({
    required this.documentImportId,
    required this.sections,
    required this.desiredCount,
    required this.difficulty,
    required this.questionStyle,
  });

  final String documentImportId;
  final List<TextSection> sections;
  final int desiredCount;
  final GenerationDifficulty difficulty;
  final QuestionStyle questionStyle;
}

final class GeneratedFlashcardDraft {
  const GeneratedFlashcardDraft({
    required this.question,
    required this.answer,
    this.difficulty,
    this.sourceReference,
  });

  final String question;
  final String answer;
  final Difficulty? difficulty;
  final String? sourceReference;
}

final class GeneratedFlashcardValidationResult {
  const GeneratedFlashcardValidationResult({
    required this.accepted,
    required this.rejectedCount,
  });

  final List<GeneratedFlashcardDraft> accepted;
  final int rejectedCount;
}
