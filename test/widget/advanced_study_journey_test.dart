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
  testWidgets('cram deck reviews a scheduled card without due CTA', (
    tester,
  ) async {
    final database = widgetMemoryDatabase();
    addTearDown(database.close);
    final clock = FakeClock(DateTime.utc(2026, 6, 15, 12));
    final ids = SequentialIdGenerator();
    final logger = RecordingLogger();
    late String deckId;

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
      ).createDeck(ownerId: user.id, name: 'Physics', description: '');
      deckId = deck.id;
      final cards = DriftFlashcardRepository(
        database: database,
        ids: ids,
        clock: clock,
        logger: logger,
      );
      final card = await cards.create(
        NewFlashcard(
          deckId: deck.id,
          question: 'What is force?',
          answer: 'Mass times acceleration.',
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
        grade: RecallGrade.good,
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
          analyticsClientProvider.overrideWithValue(const NoOpAnalyticsClient()),
        ],
        child: const FlashhhApp(),
      ),
    );

    await pumpUntilFound(tester, find.text('Physics'));
    expect(find.textContaining('Study'), findsNothing);

    await tester.tap(find.text('Physics'));
    await pumpUntilFound(tester, find.text('Cram deck'));
    await tester.tap(find.text('Cram deck'));
    await pumpUntilFound(tester, find.text('What is force?'));
    expect(find.textContaining('Cram mode'), findsOneWidget);

    await tester.tap(find.text('Show answer'));
    await pumpUntilFound(tester, find.text('Mass times acceleration.'));
    await tester.tap(find.text('Good'));
    await pumpUntilFound(tester, find.text('Cram complete'));
    expect(find.textContaining('schedule unchanged'), findsOneWidget);

    await tester.tap(find.text('Done'));
    await pumpUntilFound(tester, find.text('Physics'));

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
    expect(deckId, isNotEmpty);
  });
}
