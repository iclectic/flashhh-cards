import 'package:dio/dio.dart';

import '../../../app/configuration/app_config.dart';
import '../../../core/errors/app_exception.dart';
import '../../../core/networking/api_client.dart';
import '../../../core/networking/dio_exception_mapper.dart';
import '../../../core/utilities/app_logger.dart';
import '../../../core/validation/field_limits.dart';
import '../domain/ai_flashcard_generator.dart';
import '../domain/ai_models.dart';
import '../domain/generated_flashcard_validator.dart';
import '../domain/generation_pipeline.dart';

final class HttpDocumentTextExtractor
    implements DocumentTextExtractor, DocumentUploadExtractor {
  HttpDocumentTextExtractor({
    required Dio dio,
    required AppConfig config,
    required AppLogger logger,
  }) : _dio = dio,
       _config = config,
       _logger = logger;

  final Dio _dio;
  final AppConfig _config;
  final AppLogger _logger;

  @override
  Future<ExtractedDocumentText> extractUpload({
    required DocumentExtractionRequest request,
    required List<int> pdfBytes,
  }) async {
    try {
      final form = FormData.fromMap({
        'documentImportId': request.documentImportId,
        'file': MultipartFile.fromBytes(
          pdfBytes,
          filename: request.fileName,
        ),
      });
      final response = await _dio.post<Object>(
        'v1/documents/extract',
        data: form,
      );
      _assertAllowed(response.requestOptions.uri);
      final body = _asMap(response.data);
      final sectionsRaw = body['sections'];
      if (sectionsRaw is! List) {
        throw const DocumentException(
          message: 'The document could not be read.',
        );
      }
      final sections = <TextSection>[];
      for (final (index, item) in sectionsRaw.indexed) {
        if (item is! Map) {
          continue;
        }
        final text = item['text'];
        if (text is! String || text.trim().isEmpty) {
          continue;
        }
        sections.add(
          TextSection(
            reference: '${item['reference'] ?? 'section-${index + 1}'}',
            text: text.trim(),
          ),
        );
      }
      if (sections.isEmpty) {
        throw const DocumentException(
          message: 'The document did not contain enough text to draft cards.',
        );
      }
      final characterCount = body['characterCount'];
      return ExtractedDocumentText(
        characterCount: characterCount is int
            ? characterCount
            : sections.fold<int>(0, (sum, s) => sum + s.text.length),
        sections: sections,
        usedOcr: body['usedOcr'] == true,
      );
    } on DioException catch (error, stackTrace) {
      _logger.warning(
        'extract failed ${error.response?.statusCode}',
        stackTrace: stackTrace,
      );
      throw mapDioException(error);
    } on AppException {
      rethrow;
    } catch (error, stackTrace) {
      _logger.error('extract unexpected', error: error, stackTrace: stackTrace);
      throw const DocumentException(
        message: 'The document could not be read.',
      );
    }
  }

  @override
  Future<ExtractedDocumentText> extract(DocumentExtractionRequest request) {
    throw const DocumentException(
      message: 'PDF bytes are required to extract text from a document.',
    );
  }

  void _assertAllowed(Uri uri) {
    if (uri.scheme == 'https') {
      return;
    }
    final local = uri.host == 'localhost' || uri.host == '127.0.0.1';
    if (_config.environment == AppEnvironment.development &&
        uri.scheme == 'http' &&
        local) {
      return;
    }
    throw const UnexpectedException(
      message: 'Flashhh could not start that request.',
    );
  }

  Map<String, Object?> _asMap(Object? data) {
    if (data is Map<String, Object?>) {
      return data;
    }
    if (data is Map) {
      return data.map((key, value) => MapEntry(key.toString(), value));
    }
    throw const UnexpectedException(
      message: 'The server sent a response Flashhh could not read.',
    );
  }
}

final class HttpAiFlashcardGenerator implements AiFlashcardGenerator {
  HttpAiFlashcardGenerator({
    required ApiClient api,
    required AppConfig config,
    GeneratedFlashcardValidator validator = const GeneratedFlashcardValidator(),
  }) : _api = api,
       _config = config,
       _validator = validator;

  final ApiClient _api;
  final AppConfig _config;
  final GeneratedFlashcardValidator _validator;

  @override
  Future<GeneratedFlashcardValidationResult> generate(
    FlashcardGenerationRequest request,
  ) async {
    final body = await _api.postJson(
      'v1/flashcards/generate',
      body: {
        'documentImportId': request.documentImportId,
        'desiredCount': request.desiredCount,
        'difficulty': _difficultyWire(request.difficulty),
        'questionStyle': _styleWire(request.questionStyle),
        'sections': [
          for (final section in request.sections)
            {'reference': section.reference, 'text': section.text},
        ],
      },
    );
    return _validator.validate(
      body,
      maxCards: _config.maxGeneratedCards.clamp(1, FieldLimits.maxPageSize),
    );
  }

  String _difficultyWire(GenerationDifficulty value) => switch (value) {
    GenerationDifficulty.beginner => 'beginner',
    GenerationDifficulty.intermediate => 'intermediate',
    GenerationDifficulty.advanced => 'advanced',
  };

  String _styleWire(QuestionStyle value) => switch (value) {
    QuestionStyle.factualRecall => 'factual_recall',
    QuestionStyle.conceptualUnderstanding => 'conceptual_understanding',
    QuestionStyle.mixed => 'mixed',
  };
}
