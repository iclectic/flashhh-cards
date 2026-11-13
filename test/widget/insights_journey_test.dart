import 'package:flashhh_cards/app/app.dart';
import 'package:flashhh_cards/app/dependencies.dart';
import 'package:flashhh_cards/core/analytics/analytics_client.dart';
import 'package:flashhh_cards/core/storage/preferences/preferences_repository.dart';
import 'package:flashhh_cards/features/authentication/data/local_account_seeder.dart';
import 'package:flashhh_cards/features/decks/data/drift_deck_repository.dart';
import 'package:flashhh_cards/features/flashcards/data/drift_flashcard_repository.dart';
import 'package:flashhh_cards/features/flashcards/domain/flashcard.dart';
import 'package:flashhh_cards/features/study/data/drift_study_repository.dart';
import 'package:flashhh_cards/features/study/domain/study_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/fakes.dart';
import '../support/pump_app.dart';

void main() {
  testWidgets('insights page shows next actions after a miss', (tester) async {
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
        name: 'Biology',
        description: '',
      );
      final card = await cards.create(
        NewFlashcard(
          deckId: deck.id,
          question: 'What is a cell?',
          answer: 'The basic unit of life.',
          tags: const ['cells'],
        ),
      );
      final study = DriftStudyRepository(
        database: database,
        ids: ids,
        clock: clock,
        logger: logger,
      );
      final session = await study.startSession(deckId: deck.id);
      await study.gradeCard(
        sessionId: session.id,
        cardId: card.id,
        grade: RecallGrade.hard,
      );
      await study.completeSession(session.id);
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
        ],
        child: const FlashhhApp(),
      ),
    );

    await pumpUntilFound(tester, find.text('Biology'));
    await tester.tap(find.byTooltip('Insights'));
    await pumpUntilFound(tester, find.text('What to study next'));
    expect(find.textContaining('Focus on “cells”'), findsOneWidget);
    expect(find.text('Weak tags'), findsOneWidget);
    expect(find.text('cells'), findsWidgets);
    expect(find.text('Study calendar'), findsOneWidget);
  });
}
