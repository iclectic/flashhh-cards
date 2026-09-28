import 'dart:io';

import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:flashhh_cards/app/configuration/app_config.dart';
import 'package:flashhh_cards/core/errors/app_exception.dart';
import 'package:flashhh_cards/core/storage/database/app_database.dart';
import 'package:flashhh_cards/core/storage/preferences/preferences_repository.dart';
import 'package:flashhh_cards/features/ai_generation/data/drift_document_import_store.dart';
import 'package:flashhh_cards/features/ai_generation/data/drift_generation_usage_store.dart';
import 'package:flashhh_cards/features/ai_generation/domain/ai_models.dart';
import 'package:flashhh_cards/features/authentication/data/local_account_seeder.dart';
import 'package:flashhh_cards/features/decks/data/drift_deck_repository.dart';
import 'package:flashhh_cards/features/flashcards/data/drift_flashcard_repository.dart';
import 'package:flashhh_cards/features/flashcards/domain/flashcard.dart';
import 'package:flashhh_cards/features/study/data/study_stats_reader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/fakes.dart';

void main() {
  late AppDatabase database;
  late FakeClock clock;
  late SequentialIdGenerator ids;
  late RecordingLogger logger;
  late DriftDeckRepository decks;
  late DriftFlashcardRepository cards;
  late String ownerId;

  setUp(() async {
    database = AppDatabase(NativeDatabase.memory());
    clock = FakeClock(DateTime.utc(2026, 6, 15, 12));
    ids = SequentialIdGenerator();
    logger = RecordingLogger();
    decks = DriftDeckRepository(
      database: database,
      ids: ids,
      clock: clock,
      logger: logger,
    );
    cards = DriftFlashcardRepository(
      database: database,
      ids: ids,
      clock: clock,
      logger: logger,
    );
    final user = await LocalAccountSeeder(
      database: database,
      ids: ids,
      clock: clock,
      logger: logger,
    ).ensureGuestAccount();
    ownerId = user.id;
  });

  tearDown(() => database.close());

  test('creates, renames, counts, and soft-deletes decks', () async {
    final created = await decks.createDeck(
      ownerId: ownerId,
      name: '  Biology ',
      description: 'Cells',
    );
    await cards.create(
      NewFlashcard(
        deckId: created.id,
        question: 'What is a cell?',
        answer: 'The basic unit of life.',
      ),
    );

    final listed = await decks.listDecks(ownerId: ownerId);
    expect(listed.single.name, 'Biology');
    expect(listed.single.cardCount, 1);

    final renamed = await decks.updateDeck(
      id: created.id,
      name: 'Life science',
      description: '',
    );
    expect(renamed.name, 'Life science');

    await decks.deleteDeck(created.id);
    expect(await decks.listDecks(ownerId: ownerId), isEmpty);
    expect(await cards.search(const FlashcardQuery()), isEmpty);
    await decks.deleteDeck(created.id);
  });

  test('edits, moves, duplicates, searches, and filters cards', () async {
    final biology = await decks.createDeck(
      ownerId: ownerId,
      name: 'Biology',
      description: '',
    );
    final chemistry = await decks.createDeck(
      ownerId: ownerId,
      name: 'Chemistry',
      description: '',
    );
    final created = await cards.create(
      NewFlashcard(
        deckId: biology.id,
        question: 'What is 100% of a cell?',
        answer: 'The whole cell.',
        difficulty: Difficulty.easy,
        tags: const ['Biology'],
      ),
    );
    await cards.create(
      NewFlashcard(
        deckId: biology.id,
        question: 'What is a tissue?',
        answer: 'A group of cells.',
        difficulty: Difficulty.hard,
      ),
    );

    final edited = await cards.update(
      FlashcardUpdate(
        id: created.id,
        question: 'What is 100% of a cell?',
        answer: 'All of it.',
        difficulty: Difficulty.medium,
        tags: const ['biology', 'cells'],
      ),
    );
    expect(edited.answer, 'All of it.');
    expect(edited.tags, ['biology', 'cells']);

    final moved = await cards.move(
      id: created.id,
      destinationDeckId: chemistry.id,
    );
    expect(moved.deckId, chemistry.id);
    expect((await decks.findById(biology.id))!.cardCount, 1);
    expect((await decks.findById(chemistry.id))!.cardCount, 1);

    await (database.update(database.flashcards)
          ..where((row) => row.id.equals(created.id)))
        .write(const FlashcardsCompanion(reviewCount: Value(4)));
    final copy = await cards.duplicate(created.id);
    expect(copy.id, isNot(created.id));
    expect(copy.reviewCount, 0);
    expect(copy.easeFactor, 2.5);
    expect(copy.tags, edited.tags);

    final literalPercent = await cards.search(
      const FlashcardQuery(text: '100%'),
    );
    expect(literalPercent, hasLength(2));
    final byTag = await cards.search(const FlashcardQuery(tag: 'CELLS'));
    expect(byTag, hasLength(2));
    final hardOnly = await cards.search(
      const FlashcardQuery(difficulty: Difficulty.hard),
    );
    expect(hardOnly.single.question, 'What is a tissue?');
    final page = await cards.search(const FlashcardQuery(limit: 1));
    expect(page, hasLength(1));

    await cards.delete(created.id);
    expect(await cards.findById(created.id), isNull);
    expect(
      () => cards.move(id: created.id, destinationDeckId: biology.id),
      throwsA(isA<ValidationException>()),
    );
  });

  test(
    'dashboard counts due cards, today, streak, and deck progress',
    () async {
      final deck = await decks.createDeck(
        ownerId: ownerId,
        name: 'Biology',
        description: '',
      );
      final card = await cards.create(
        NewFlashcard(
          deckId: deck.id,
          question: 'What is a cell?',
          answer: 'The basic unit of life.',
        ),
      );
      final reader = StudyStatsReader(database: database, logger: logger);
      final before = await reader.load(now: clock.now());
      expect(before.cardsDue, 1);
      expect(before.cardsStudiedToday, 0);
      expect(before.streak, 0);
      expect(before.decks.single.reviewedCards, 0);

      await database
          .into(database.studySessions)
          .insert(
            StudySessionsCompanion.insert(
              id: 'session-1',
              startedAt: clock.now(),
            ),
          );
      await database
          .into(database.reviewResults)
          .insert(
            ReviewResultsCompanion.insert(
              id: 'review-1',
              sessionId: 'session-1',
              cardId: card.id,
              grade: 'good',
              reviewedAt: clock.now(),
            ),
          );
      final tomorrow = clock.now().add(const Duration(days: 1));
      await (database.update(
        database.flashcards,
      )..where((row) => row.id.equals(card.id))).write(
        FlashcardsCompanion(
          reviewCount: const Value(1),
          nextReviewAt: Value(tomorrow),
        ),
      );

      final after = await reader.load(now: clock.now());
      expect(after.cardsDue, 0);
      expect(after.cardsStudiedToday, 1);
      expect(after.streak, 1);
      expect(after.decks.single.reviewedCards, 1);
      expect(after.decks.single.totalCards, 1);

      await decks.deleteDeck(deck.id);
      final hidden = await reader.load(now: clock.now());
      expect(hidden.cardsDue, 0);
      expect(hidden.decks, isEmpty);
      expect(hidden.cardsStudiedToday, 1);
    },
  );

  test(
    'preferences and the guest account survive a database restart',
    () async {
      final directory = await Directory.systemTemp.createTemp('flashhh_test');
      final file = File('${directory.path}/flashhh.sqlite');
      // The first connection is closed before the second opens. Drift still
      // warns because it counts constructions, not overlapping connections.
      final warn = driftRuntimeOptions.dontWarnAboutMultipleDatabases;
      driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
      addTearDown(
        () => driftRuntimeOptions.dontWarnAboutMultipleDatabases = warn,
      );
      final first = AppDatabase(NativeDatabase(file));
      final firstLogger = RecordingLogger();
      final firstClock = FakeClock(DateTime.utc(2026, 6, 15, 12));
      final firstIds = SequentialIdGenerator();
      final preferences = DriftPreferencesRepository(first, firstLogger);
      await preferences.setOnboardingCompleted(completed: true);
      await preferences.setThemeMode(ThemeMode.dark);
      final user = await LocalAccountSeeder(
        database: first,
        ids: firstIds,
        clock: firstClock,
        logger: firstLogger,
      ).ensureGuestAccount();
      await first.close();

      final second = AppDatabase(NativeDatabase(file));
      final restored = DriftPreferencesRepository(second, RecordingLogger());
      expect(await restored.watchOnboardingCompleted().first, isTrue);
      expect(await restored.watchThemeMode().first, ThemeMode.dark);
      final again = await LocalAccountSeeder(
        database: second,
        ids: SequentialIdGenerator(),
        clock: firstClock,
        logger: RecordingLogger(),
      ).ensureGuestAccount();
      expect(again.id, user.id);
      await second.close();
      await directory.delete(recursive: true);
    },
  );

  test(
    'document metadata can be recorded and deleted without file bytes',
    () async {
      final config = AppConfig(
        environment: AppEnvironment.development,
        apiBaseUrl: Uri.parse('https://api.flashhh.app'),
        maxUploadBytes: 1000,
        maxGeneratedCards: 10,
      );
      final imports = DriftDocumentImportStore(
        database: database,
        ids: ids,
        clock: clock,
        logger: logger,
        config: config,
      );
      final usage = DriftGenerationUsageStore(
        database: database,
        logger: logger,
      );
      final record = await imports.create(fileName: 'notes.pdf', byteSize: 120);
      await usage.record(
        GenerationUsageRecord(
          id: 'usage-1',
          documentImportId: record.id,
          createdAt: clock.now(),
          status: GenerationStatus.failed,
          documentBytes: 120,
          failureCode: 'provider_timeout',
        ),
      );

      expect(await imports.findById(record.id), isNotNull);
      expect((await usage.listRecent()).single.documentImportId, record.id);

      await imports.delete(record.id);
      expect(await imports.findById(record.id), isNull);
      expect(await usage.listRecent(), isEmpty);
      expect(
        () => imports.create(fileName: 'scan.png', byteSize: 10),
        throwsA(isA<DocumentException>()),
      );
    },
  );
}
