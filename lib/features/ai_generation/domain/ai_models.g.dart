// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DocumentImport _$DocumentImportFromJson(Map<String, dynamic> json) =>
    _DocumentImport(
      id: json['id'] as String,
      fileName: json['fileName'] as String,
      byteSize: (json['byteSize'] as num).toInt(),
      contentHash: json['contentHash'] as String?,
      pageCount: (json['pageCount'] as num?)?.toInt(),
      textCharacterCount: (json['textCharacterCount'] as num?)?.toInt(),
      status: $enumDecode(_$DocumentImportStatusEnumMap, json['status']),
      errorMessage: json['errorMessage'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      discardedAt: json['discardedAt'] == null
          ? null
          : DateTime.parse(json['discardedAt'] as String),
    );

Map<String, dynamic> _$DocumentImportToJson(_DocumentImport instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fileName': instance.fileName,
      'byteSize': instance.byteSize,
      'contentHash': instance.contentHash,
      'pageCount': instance.pageCount,
      'textCharacterCount': instance.textCharacterCount,
      'status': _$DocumentImportStatusEnumMap[instance.status]!,
      'errorMessage': instance.errorMessage,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'discardedAt': instance.discardedAt?.toIso8601String(),
    };

const _$DocumentImportStatusEnumMap = {
  DocumentImportStatus.selected: 'selected',
  DocumentImportStatus.validating: 'validating',
  DocumentImportStatus.extracting: 'extracting',
  DocumentImportStatus.readyForGeneration: 'ready_for_generation',
  DocumentImportStatus.generating: 'generating',
  DocumentImportStatus.readyForReview: 'ready_for_review',
  DocumentImportStatus.saved: 'saved',
  DocumentImportStatus.failed: 'failed',
  DocumentImportStatus.discarded: 'discarded',
};

_GenerationUsageRecord _$GenerationUsageRecordFromJson(
  Map<String, dynamic> json,
) => _GenerationUsageRecord(
  id: json['id'] as String,
  documentImportId: json['documentImportId'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  status: $enumDecode(_$GenerationStatusEnumMap, json['status']),
  documentBytes: (json['documentBytes'] as num?)?.toInt(),
  promptTokens: (json['promptTokens'] as num?)?.toInt(),
  completionTokens: (json['completionTokens'] as num?)?.toInt(),
  cardCount: (json['cardCount'] as num?)?.toInt(),
  estimatedCostUsd: (json['estimatedCostUsd'] as num?)?.toDouble(),
  failureCode: json['failureCode'] as String?,
);

Map<String, dynamic> _$GenerationUsageRecordToJson(
  _GenerationUsageRecord instance,
) => <String, dynamic>{
  'id': instance.id,
  'documentImportId': instance.documentImportId,
  'createdAt': instance.createdAt.toIso8601String(),
  'status': _$GenerationStatusEnumMap[instance.status]!,
  'documentBytes': instance.documentBytes,
  'promptTokens': instance.promptTokens,
  'completionTokens': instance.completionTokens,
  'cardCount': instance.cardCount,
  'estimatedCostUsd': instance.estimatedCostUsd,
  'failureCode': instance.failureCode,
};

const _$GenerationStatusEnumMap = {
  GenerationStatus.started: 'started',
  GenerationStatus.completed: 'completed',
  GenerationStatus.failed: 'failed',
};
