import '../../../core/errors/app_exception.dart';
import '../../../core/validation/field_limits.dart';
import 'ai_models.dart';

abstract final class DocumentImportPolicy {
  static void validateNew({
    required String fileName,
    required int byteSize,
    required int maxBytes,
  }) {
    final name = fileName.trim();
    if (name.isEmpty ||
        name.contains('/') ||
        name.contains(r'\') ||
        name.contains('..')) {
      throw const DocumentException(
        message: 'Choose a document with a valid file name.',
      );
    }
    if (name.length > FieldLimits.fileName) {
      throw const DocumentException(message: 'That file name is too long.');
    }
    if (!name.toLowerCase().endsWith('.pdf')) {
      throw const DocumentException(
        message: 'Only PDF documents can be imported.',
      );
    }
    if (byteSize <= 0) {
      throw const DocumentException(message: 'That document is empty.');
    }
    if (byteSize > maxBytes) {
      throw const DocumentException(
        message: 'That document is too large to import.',
      );
    }
  }
}

abstract final class GenerationUsagePolicy {
  static void validate(GenerationUsageRecord record) {
    _nonNegative(record.documentBytes, 'Document size is invalid.');
    _nonNegative(record.promptTokens, 'Token usage is invalid.');
    _nonNegative(record.completionTokens, 'Token usage is invalid.');
    _nonNegative(record.cardCount, 'Card count is invalid.');
    final cost = record.estimatedCostUsd;
    if (cost != null && cost < 0) {
      throw const ValidationException(message: 'Estimated cost is invalid.');
    }
    final code = record.failureCode;
    if (code != null &&
        (code.trim().isEmpty || code.length > FieldLimits.failureCode)) {
      throw const ValidationException(message: 'The failure code is invalid.');
    }
  }

  static void _nonNegative(int? value, String message) {
    if (value != null && value < 0) {
      throw ValidationException(message: message);
    }
  }
}
