import 'package:flashhh_cards/app/app.dart';
import 'package:flashhh_cards/app/dependencies.dart';
import 'package:flashhh_cards/core/analytics/analytics_client.dart';
import 'package:flashhh_cards/core/storage/preferences/preferences_repository.dart';
import 'package:flashhh_cards/features/authentication/data/local_account_seeder.dart';
import 'package:flashhh_cards/features/decks/data/drift_deck_repository.dart';
import 'package:flashhh_cards/features/flashcards/data/drift_flashcard_repository.dart';
import 'package:flashhh_cards/features/flashcards/domain/flashcard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/fakes.dart';
import '../support/pump_app.dart';

void main() {
  testWidgets('study session reveals, grades, and updates the dashboard', (
    tester,
  ) async {
    final database = widgetMemoryDatabase();
    addTearDown(database.close);
    final clock = FakeClock(DateTime.utc(2026, 6, 15, 12));
    final ids = SequentialIdGenerator();
    final logger = RecordingLogger();

    await tester.runAsync(() async {
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
      ).createDeck(ownerId: user.id, name: 'Biology', description: '');
      await DriftFlashcardRepository(
        database: database,
        ids: ids,
        clock: clock,
        logger: logger,
      ).create(
        NewFlashcard(
          deckId: deck.id,
          question: 'What is a cell?',
          answer: 'The basic unit of life.',
        ),
      );
      await DriftPreferencesRepository(
        database,
        logger,
      ).setOnboardingCompleted(completed: true);
    });

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(database),
          clockProvider.overrideWithValue(clock),
          idGeneratorProvider.overrideWithValue(ids),
          analyticsClientProvider.overrideWithValue(const NoOpAnalyticsClient()),
        ],
        child: const FlashhhApp(),
      ),
    );

    await pumpUntilFound(tester, find.text('Study 1 due card'));
    await tester.tap(find.text('Study 1 due card'));
    await pumpUntilFound(tester, find.text('What is a cell?'));
    expect(find.text('Show answer'), findsOneWidget);

    await tester.tap(find.text('Show answer'));
    await pumpUntilFound(tester, find.text('The basic unit of life.'));
    await tester.tap(find.text('Good'));
    await pumpUntilFound(tester, find.text('Session complete'));
    expect(find.text('Nice work'), findsOneWidget);
    expect(find.text('You reviewed 1 card.'), findsOneWidget);

    await tester.tap(find.text('Done'));
    await pumpUntilFound(tester, find.text('1 of 1 reviewed'));
    expect(find.text('Study 1 due card'), findsNothing);
    expect(find.text('Biology'), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
  });
}
