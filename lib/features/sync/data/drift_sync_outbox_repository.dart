import 'package:drift/drift.dart';

import '../../../core/errors/app_exception.dart';
import '../../../core/storage/database/app_database.dart';
import '../../../core/utilities/app_logger.dart';
import '../../../core/utilities/clock.dart';
import '../../../core/utilities/database_guard.dart';
import '../../../core/utilities/id_generator.dart';
import '../../../core/validation/field_limits.dart';
import '../domain/sync_models.dart';
import '../domain/sync_outbox_repository.dart';

final class DriftSyncOutboxRepository implements SyncOutboxRepository {
  DriftSyncOutboxRepository({
    required AppDatabase database,
    required IdGenerator ids,
    required Clock clock,
    required AppLogger logger,
  }) : _database = database,
       _ids = ids,
       _clock = clock,
       _logger = logger;

  final AppDatabase _database;
  final IdGenerator _ids;
  final Clock _clock;
  final AppLogger _logger;

  @override
  Future<SyncOutboxEntry> enqueue({
    required SyncEntityType entityType,
    required String entityId,
    required SyncOperation operation,
    String? payloadJson,
  }) {
    if (entityId.trim().isEmpty) {
      throw const ValidationException(
        message: 'A sync change needs an entity id.',
      );
    }
    final payload = payloadJson;
    if (payload != null && payload.length > FieldLimits.syncPayload) {
      throw const ValidationException(
        message: 'That sync payload is too large to queue.',
      );
    }
    return runDatabase(
      logger: _logger,
      message: 'The change could not be queued for sync.',
      action: () async {
        final now = _clock.now();
        final id = _ids.next();
        await _database
            .into(_database.syncOutboxEntries)
            .insert(
              SyncOutboxEntriesCompanion.insert(
                id: id,
                entityType: entityType.name,
                entityId: entityId,
                operation: operation.name,
                payloadJson: Value(payload),
                createdAt: now,
              ),
            );
        return SyncOutboxEntry(
          id: id,
          entityType: entityType,
          entityId: entityId,
          operation: operation,
          payloadJson: payload,
          createdAt: now,
        );
      },
    );
  }

  @override
  Future<List<SyncOutboxEntry>> listPending({int limit = 100}) {
    final pageSize = limit.clamp(1, FieldLimits.maxPageSize);
    return runDatabase(
      logger: _logger,
      message: 'Pending sync changes could not be loaded.',
      action: () async {
        final rows =
            await (_database.select(_database.syncOutboxEntries)
                  ..where((row) => row.processedAt.isNull())
                  ..orderBy([(row) => OrderingTerm.asc(row.createdAt)])
                  ..limit(pageSize))
                .get();
        return rows.map(_map).toList();
      },
    );
  }

  @override
  Future<int> pendingCount() {
    return runDatabase(
      logger: _logger,
      message: 'Pending sync changes could not be counted.',
      action: () async {
        final count = _database.syncOutboxEntries.id.count();
        final query = _database.selectOnly(_database.syncOutboxEntries)
          ..addColumns([count])
          ..where(_database.syncOutboxEntries.processedAt.isNull());
        final row = await query.getSingle();
        return row.read(count) ?? 0;
      },
    );
  }

  @override
  Future<void> markAttempt({required String id, String? lastError}) {
    return runDatabase(
      logger: _logger,
      message: 'The sync attempt could not be recorded.',
      action: () async {
        final existing =
            await (_database.select(_database.syncOutboxEntries)
                  ..where((row) => row.id.equals(id)))
                .getSingleOrNull();
        if (existing == null) {
          return;
        }
        await (_database.update(
          _database.syncOutboxEntries,
        )..where((row) => row.id.equals(id))).write(
          SyncOutboxEntriesCompanion(
            attemptCount: Value(existing.attemptCount + 1),
            lastError: Value(lastError),
          ),
        );
      },
    );
  }

  @override
  Future<void> markProcessed(String id) {
    return runDatabase(
      logger: _logger,
      message: 'The sync change could not be marked done.',
      action: () async {
        await (_database.update(
          _database.syncOutboxEntries,
        )..where((row) => row.id.equals(id))).write(
          SyncOutboxEntriesCompanion(processedAt: Value(_clock.now())),
        );
      },
    );
  }

  @override
  Future<void> clearProcessed() {
    return runDatabase(
      logger: _logger,
      message: 'Processed sync changes could not be cleared.',
      action: () async {
        await (_database.delete(
          _database.syncOutboxEntries,
        )..where((row) => row.processedAt.isNotNull())).go();
      },
    );
  }

  SyncOutboxEntry _map(SyncOutboxRow row) {
    return SyncOutboxEntry(
      id: row.id,
      entityType: SyncEntityType.values.byName(row.entityType),
      entityId: row.entityId,
      operation: SyncOperation.values.byName(row.operation),
      payloadJson: row.payloadJson,
      createdAt: row.createdAt.toUtc(),
      attemptCount: row.attemptCount,
      lastError: row.lastError,
      processedAt: row.processedAt?.toUtc(),
    );
  }
}
