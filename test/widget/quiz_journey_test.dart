import 'dart:math';

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
  testWidgets('quiz a deck with short answers and see results', (tester) async {
    tester.view.physicalSize = const Size(800, 2000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);

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
      final decks = DriftDeckRepository(
        database: database,
        ids: ids,
        clock: clock,
        logger: logger,
      );
      final cards = DriftFlashcardRepository(
        database: database,
        ids: ids,
        clock: clock,
        logger: logger,
      );
      final deck = await decks.createDeck(
        ownerId: user.id,
        name: 'Interview',
        description: '',
      );
      await cards.create(
        NewFlashcard(
          deckId: deck.id,
          question: 'What is CAP?',
          answer: 'Consistency Availability Partition tolerance',
        ),
      );
      await cards.create(
        NewFlashcard(
          deckId: deck.id,
          question: 'What is ACID?',
          answer: 'Atomicity Consistency Isolation Durability',
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
          analyticsClientProvider.overrideWithValue(
            const NoOpAnalyticsClient(),
          ),
          quizRandomProvider.overrideWithValue(Random(7)),
        ],
        child: const FlashhhApp(),
      ),
    );

    await pumpUntilFound(tester, find.text('Interview'));
    await tester.tap(find.byTooltip('Quiz'));
    await pumpUntilFound(tester, find.text('Prove what you know'));

    await tester.tap(find.text('Short answer'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Start quiz'));
    await pumpUntilFound(tester, find.text('1 of 2'));

    await tester.enterText(
      find.widgetWithText(TextField, 'Your answer'),
      'wrong-one',
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Submit answer'));
    await pumpUntilFound(tester, find.text('2 of 2'));

    await tester.enterText(
      find.widgetWithText(TextField, 'Your answer'),
      'wrong-two',
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Finish quiz'));
    await pumpUntilFound(tester, find.text('0/2 correct'));
    expect(find.text('Quiz results'), findsOneWidget);
    expect(find.textContaining('Correct:'), findsWidgets);
  });
}
