import 'package:freezed_annotation/freezed_annotation.dart';

part 'sync_models.freezed.dart';
part 'sync_models.g.dart';

@JsonEnum(fieldRename: FieldRename.snake)
enum SyncEntityType { user, deck, flashcard }

@JsonEnum(fieldRename: FieldRename.snake)
enum SyncOperation { upsert, delete }

@freezed
abstract class SyncOutboxEntry with _$SyncOutboxEntry {
  const factory SyncOutboxEntry({
    required String id,
    required SyncEntityType entityType,
    required String entityId,
    required SyncOperation operation,
    String? payloadJson,
    required DateTime createdAt,
    @Default(0) int attemptCount,
    String? lastError,
    DateTime? processedAt,
  }) = _SyncOutboxEntry;

  factory SyncOutboxEntry.fromJson(Map<String, dynamic> json) =>
      _$SyncOutboxEntryFromJson(json);
}

@freezed
abstract class SyncStatus with _$SyncStatus {
  const factory SyncStatus({
    required int pendingCount,
    required bool cloudSyncAvailable,
  }) = _SyncStatus;

  factory SyncStatus.fromJson(Map<String, dynamic> json) =>
      _$SyncStatusFromJson(json);
}
