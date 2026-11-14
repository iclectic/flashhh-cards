import 'package:flashhh_cards/core/validation/field_limits.dart';
import 'package:flashhh_cards/features/authentication/data/local_account_seeder.dart';
import 'package:flashhh_cards/features/decks/data/drift_deck_repository.dart';
import 'package:flashhh_cards/features/flashcards/data/drift_flashcard_repository.dart';
import 'package:flashhh_cards/features/flashcards/domain/flashcard.dart';
import 'package:flashhh_cards/features/flashcards/presentation/deck_cards_controller.dart';
import 'package:flashhh_cards/app/dependencies.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/fakes.dart';
import '../support/pump_app.dart';

void main() {
  test('deck cards controller pages beyond the first 50 cards', () async {
    final database = memoryDatabase();
    addTearDown(database.close);
    final clock = FakeClock(DateTime.utc(2026, 6, 15, 12));
    final ids = SequentialIdGenerator();
    final logger = RecordingLogger();

    final user = await LocalAccountSeeder(
      database: database,
      ids: ids,
      clock: clock,
      logger: logger,
    ).ensureGuestAccount();
    final deck = await DriftDeckRepository(
      database: database,
      ids: ids,
      clock: clock,
      logger: logger,
    ).createDeck(ownerId: user.id, name: 'Big', description: '');
    final cards = DriftFlashcardRepository(
      database: database,
      ids: ids,
      clock: clock,
      logger: logger,
    );
    for (var i = 0; i < FieldLimits.pageSize + 3; i++) {
      await cards.create(
        NewFlashcard(
          deckId: deck.id,
          question: 'Q$i',
          answer: 'A$i',
        ),
      );
    }

    final container = ProviderContainer(
      overrides: [
        appDatabaseProvider.overrideWithValue(database),
        clockProvider.overrideWithValue(clock),
        idGeneratorProvider.overrideWithValue(ids),
        appLoggerProvider.overrideWithValue(logger),
      ],
    );
    addTearDown(container.dispose);

    final first = await container.read(
      deckCardsControllerProvider(deck.id).future,
    );
    expect(first.cards, hasLength(FieldLimits.pageSize));
    expect(first.hasMore, isTrue);

    await container
        .read(deckCardsControllerProvider(deck.id).notifier)
        .loadMore();
    final second = container
        .read(deckCardsControllerProvider(deck.id))
        .requireValue;
    expect(second.cards, hasLength(FieldLimits.pageSize + 3));
    expect(second.hasMore, isFalse);
  });
}
