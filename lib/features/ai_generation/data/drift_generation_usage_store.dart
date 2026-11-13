import 'package:drift/drift.dart';

import '../../../core/storage/database/app_database.dart';
import '../../../core/utilities/app_logger.dart';
import '../../../core/utilities/database_guard.dart';
import '../domain/ai_models.dart';
import '../domain/import_policy.dart';

abstract interface class GenerationUsageStore {
  Future<void> record(GenerationUsageRecord record);

  Future<List<GenerationUsageRecord>> listRecent({int limit = 50});
}

final class DriftGenerationUsageStore implements GenerationUsageStore {
  DriftGenerationUsageStore({
    required AppDatabase database,
    required AppLogger logger,
  }) : _database = database,
       _logger = logger;

  final AppDatabase _database;
  final AppLogger _logger;

  @override
  Future<void> record(GenerationUsageRecord record) {
    GenerationUsagePolicy.validate(record);
    return runDatabase(
      logger: _logger,
      message: 'Generation usage could not be recorded.',
      action: () {
        return _database
            .into(_database.generationUsageRecords)
            .insert(
              GenerationUsageRecordsCompanion.insert(
                id: record.id,
                documentImportId: Value(record.documentImportId),
                createdAt: record.createdAt,
                status: record.status.name,
                documentBytes: Value(record.documentBytes),
                promptTokens: Value(record.promptTokens),
                completionTokens: Value(record.completionTokens),
                cardCount: Value(record.cardCount),
                estimatedCostUsd: Value(record.estimatedCostUsd),
                failureCode: Value(record.failureCode),
              ),
            );
      },
    );
  }

  @override
  Future<List<GenerationUsageRecord>> listRecent({int limit = 50}) {
    return runDatabase(
      logger: _logger,
      message: 'Generation usage could not be loaded.',
      action: () async {
        final rows =
            await (_database.select(_database.generationUsageRecords)
                  ..orderBy([
                    (row) => OrderingTerm(
                      expression: row.createdAt,
                      mode: OrderingMode.desc,
                    ),
                  ])
                  ..limit(limit))
                .get();
        return rows.map(_map).toList();
      },
    );
  }

  GenerationUsageRecord _map(GenerationUsageRow row) {
    return GenerationUsageRecord(
      id: row.id,
      documentImportId: row.documentImportId,
      createdAt: row.createdAt.toUtc(),
      status: GenerationStatus.values.byName(row.status),
      documentBytes: row.documentBytes,
      promptTokens: row.promptTokens,
      completionTokens: row.completionTokens,
      cardCount: row.cardCount,
      estimatedCostUsd: row.estimatedCostUsd,
      failureCode: row.failureCode,
    );
  }
}
