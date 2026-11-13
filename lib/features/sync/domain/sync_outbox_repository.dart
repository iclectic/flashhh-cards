import 'sync_models.dart';

abstract interface class SyncOutboxRepository {
  Future<SyncOutboxEntry> enqueue({
    required SyncEntityType entityType,
    required String entityId,
    required SyncOperation operation,
    String? payloadJson,
  });

  Future<List<SyncOutboxEntry>> listPending({int limit = 100});

  Future<int> pendingCount();

  Future<void> markAttempt({
    required String id,
    String? lastError,
  });

  Future<void> markProcessed(String id);

  Future<void> clearProcessed();
}
