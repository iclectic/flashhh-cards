import 'package:drift/drift.dart';

import '../../../app/configuration/app_config.dart';
import '../../../core/storage/database/app_database.dart';
import '../../../core/utilities/app_logger.dart';
import '../../../core/utilities/clock.dart';
import '../../../core/utilities/database_guard.dart';
import '../../../core/utilities/id_generator.dart';
import '../domain/ai_models.dart';
import '../domain/import_policy.dart';

abstract interface class DocumentImportStore {
  Future<DocumentImport> create({
    required String fileName,
    required int byteSize,
    String? contentHash,
  });

  Future<DocumentImport?> findById(String id);

  /// Removes import metadata and related usage rows.
  ///
  /// PDF bytes are not stored. This deletes the record of the import.
  Future<void> delete(String id);
}

final class DriftDocumentImportStore implements DocumentImportStore {
  DriftDocumentImportStore({
    required AppDatabase database,
    required IdGenerator ids,
    required Clock clock,
    required AppLogger logger,
    required AppConfig config,
  }) : _database = database,
       _ids = ids,
       _clock = clock,
       _logger = logger,
       _config = config;

  final AppDatabase _database;
  final IdGenerator _ids;
  final Clock _clock;
  final AppLogger _logger;
  final AppConfig _config;

  @override
  Future<DocumentImport> create({
    required String fileName,
    required int byteSize,
    String? contentHash,
  }) {
    DocumentImportPolicy.validateNew(
      fileName: fileName,
      byteSize: byteSize,
      maxBytes: _config.maxUploadBytes,
    );
    return runDatabase(
      logger: _logger,
      message: 'The document could not be recorded on this device.',
      action: () async {
        final now = _clock.now();
        final id = _ids.next();
        await _database
            .into(_database.documentImports)
            .insert(
              DocumentImportsCompanion.insert(
                id: id,
                fileName: fileName.trim(),
                byteSize: byteSize,
                contentHash: Value(contentHash),
                status: DocumentImportStatus.selected.name,
                createdAt: now,
                updatedAt: now,
              ),
            );
        final created = await findById(id);
        if (created == null) {
          throw StateError('Document import insert did not persist.');
        }
        return created;
      },
    );
  }

  @override
  Future<DocumentImport?> findById(String id) {
    return runDatabase(
      logger: _logger,
      message: 'The document record could not be loaded.',
      action: () async {
        final row = await (_database.select(
          _database.documentImports,
        )..where((item) => item.id.equals(id))).getSingleOrNull();
        return row == null ? null : _map(row);
      },
    );
  }

  @override
  Future<void> delete(String id) {
    return runDatabase(
      logger: _logger,
      message: 'The document record could not be deleted.',
      action: () async {
        await _database.transaction(() async {
          await (_database.delete(
            _database.generationUsageRecords,
          )..where((row) => row.documentImportId.equals(id))).go();
          await (_database.delete(
            _database.documentImports,
          )..where((row) => row.id.equals(id))).go();
        });
      },
    );
  }

  DocumentImport _map(DocumentImportRow row) {
    return DocumentImport(
      id: row.id,
      fileName: row.fileName,
      byteSize: row.byteSize,
      contentHash: row.contentHash,
      pageCount: row.pageCount,
      textCharacterCount: row.textCharacterCount,
      status: DocumentImportStatus.values.byName(row.status),
      errorMessage: row.errorMessage,
      createdAt: row.createdAt.toUtc(),
      updatedAt: row.updatedAt.toUtc(),
      discardedAt: row.discardedAt?.toUtc(),
    );
  }
}
