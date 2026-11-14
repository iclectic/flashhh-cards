import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'tables.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Users,
    Decks,
    Flashcards,
    FlashcardTags,
    StudySessions,
    ReviewResults,
    DocumentImports,
    GenerationUsageRecords,
    AppPreferences,
    SyncOutboxEntries,
    QuizAttempts,
    QuizAnswers,
  ],
)
final class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);

  factory AppDatabase.open() => AppDatabase(_openConnection());

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'flashhh',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) async {
      await migrator.createAll();
    },
    onUpgrade: (migrator, from, to) async {
      if (from < 2) {
        await migrator.createTable(syncOutboxEntries);
      }
      if (from < 3) {
        await migrator.createTable(quizAttempts);
        await migrator.createTable(quizAnswers);
      }
      if (from < 4) {
        await migrator.addColumn(flashcards, flashcards.cardType);
        await migrator.addColumn(studySessions, studySessions.mode);
      }
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}
