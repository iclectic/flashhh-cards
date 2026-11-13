import 'package:drift/native.dart';
import 'package:flashhh_cards/core/storage/database/app_database.dart';
import 'package:flashhh_cards/features/authentication/data/local_account_seeder.dart';
import 'package:flashhh_cards/features/decks/data/drift_deck_repository.dart';
import 'package:flashhh_cards/features/flashcards/data/drift_flashcard_repository.dart';
import 'package:flashhh_cards/features/flashcards/domain/flashcard.dart';
import 'package:flashhh_cards/features/sync/data/drift_sync_outbox_repository.dart';
import 'package:flashhh_cards/features/sync/domain/sync_models.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/fakes.dart';

void main() {
  late AppDatabase database;
  late FakeClock clock;
  late SequentialIdGenerator ids;
  late RecordingLogger logger;
  late DriftSyncOutboxRepository outbox;
  late DriftDeckRepository decks;
  late DriftFlashcardRepository cards;
  late String ownerId;

  setUp(() async {
    database = AppDatabase(NativeDatabase.memory());
    clock = FakeClock(DateTime.utc(2026, 6, 15, 12));
    ids = SequentialIdGenerator();
    logger = RecordingLogger();
    outbox = DriftSyncOutboxRepository(
      database: database,
      ids: ids,
      clock: clock,
      logger: logger,
    );
    decks = DriftDeckRepository(
      database: database,
      ids: ids,
      clock: clock,
      logger: logger,
      syncOutbox: outbox,
    );
    cards = DriftFlashcardRepository(
      database: database,
      ids: ids,
      clock: clock,
      logger: logger,
      syncOutbox: outbox,
    );
    ownerId = (await LocalAccountSeeder(
      database: database,
      ids: ids,
      clock: clock,
      logger: logger,
    ).ensureGuestAccount()).id;
  });

  tearDown(() => database.close());

  test('deck and card mutations enqueue pending sync rows', () async {
    final deck = await decks.createDeck(
      ownerId: ownerId,
      name: 'Systems',
      description: '',
    );
    final card = await cards.create(
      NewFlashcard(
        deckId: deck.id,
        question: 'What is CAP?',
        answer: 'Consistency, Availability, Partition tolerance.',
      ),
    );
    await cards.delete(card.id);
    await decks.deleteDeck(deck.id);

    final pending = await outbox.listPending();
    expect(pending.length, greaterThanOrEqualTo(4));
    expect(
      pending.map((row) => row.entityType),
      containsAll([SyncEntityType.deck, SyncEntityType.flashcard]),
    );
    expect(await outbox.pendingCount(), pending.length);

    await outbox.markProcessed(pending.first.id);
    expect(await outbox.pendingCount(), pending.length - 1);
  });
}
