// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SyncOutboxEntry _$SyncOutboxEntryFromJson(Map<String, dynamic> json) =>
    _SyncOutboxEntry(
      id: json['id'] as String,
      entityType: $enumDecode(_$SyncEntityTypeEnumMap, json['entityType']),
      entityId: json['entityId'] as String,
      operation: $enumDecode(_$SyncOperationEnumMap, json['operation']),
      payloadJson: json['payloadJson'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      attemptCount: (json['attemptCount'] as num?)?.toInt() ?? 0,
      lastError: json['lastError'] as String?,
      processedAt: json['processedAt'] == null
          ? null
          : DateTime.parse(json['processedAt'] as String),
    );

Map<String, dynamic> _$SyncOutboxEntryToJson(_SyncOutboxEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'entityType': _$SyncEntityTypeEnumMap[instance.entityType]!,
      'entityId': instance.entityId,
      'operation': _$SyncOperationEnumMap[instance.operation]!,
      'payloadJson': instance.payloadJson,
      'createdAt': instance.createdAt.toIso8601String(),
      'attemptCount': instance.attemptCount,
      'lastError': instance.lastError,
      'processedAt': instance.processedAt?.toIso8601String(),
    };

const _$SyncEntityTypeEnumMap = {
  SyncEntityType.user: 'user',
  SyncEntityType.deck: 'deck',
  SyncEntityType.flashcard: 'flashcard',
};

const _$SyncOperationEnumMap = {
  SyncOperation.upsert: 'upsert',
  SyncOperation.delete: 'delete',
};

_SyncStatus _$SyncStatusFromJson(Map<String, dynamic> json) => _SyncStatus(
  pendingCount: (json['pendingCount'] as num).toInt(),
  cloudSyncAvailable: json['cloudSyncAvailable'] as bool,
);

Map<String, dynamic> _$SyncStatusToJson(_SyncStatus instance) =>
    <String, dynamic>{
      'pendingCount': instance.pendingCount,
      'cloudSyncAvailable': instance.cloudSyncAvailable,
    };
