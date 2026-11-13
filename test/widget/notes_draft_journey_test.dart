import 'package:flashhh_cards/app/app.dart';
import 'package:flashhh_cards/app/dependencies.dart';
import 'package:flashhh_cards/core/analytics/analytics_client.dart';
import 'package:flashhh_cards/core/storage/preferences/preferences_repository.dart';
import 'package:flashhh_cards/features/ai_generation/domain/heuristic_flashcard_generator.dart';
import 'package:flashhh_cards/features/authentication/data/local_account_seeder.dart';
import 'package:flashhh_cards/features/decks/data/drift_deck_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/fakes.dart';
import '../support/pump_app.dart';

void main() {
  testWidgets('notes generate drafts that can be saved into a deck', (
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
      await DriftDeckRepository(
        database: database,
        ids: ids,
        clock: clock,
        logger: logger,
      ).createDeck(ownerId: user.id, name: 'Interview', description: '');
      await DriftPreferencesRepository(
        database,
        logger,
      ).setOnboardingCompleted(completed: true);
    });

    final heuristic = HeuristicAiFlashcardGenerator(maxCards: 20);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(database),
          clockProvider.overrideWithValue(clock),
          idGeneratorProvider.overrideWithValue(ids),
          analyticsClientProvider.overrideWithValue(const NoOpAnalyticsClient()),
          aiFlashcardGeneratorProvider.overrideWithValue(heuristic),
          heuristicAiFlashcardGeneratorProvider.overrideWithValue(heuristic),
        ],
        child: const FlashhhApp(),
      ),
    );

    await pumpUntilFound(tester, find.byTooltip('Import PDF'));
    await tester.tap(find.byTooltip('Import PDF'));
    await pumpUntilFound(tester, find.widgetWithText(TextButton, 'Paste notes'));
    await tester.tap(find.widgetWithText(TextButton, 'Paste notes'));
    await pumpUntilFound(
      tester,
      find.widgetWithText(FilledButton, 'Generate drafts'),
    );

    final fields = find.byType(TextField);
    expect(fields, findsAtLeastNWidgets(2));
    await tester.enterText(fields.at(0), 'Caching');
    await tester.enterText(
      fields.at(1),
      'Caching stores expensive results for reuse. '
      'A cache hit returns a stored value without recomputation. '
      'A cache miss loads data from the source of truth. '
      'TTL policies expire entries after a fixed duration. '
      'Eviction strategies remove cold entries under memory pressure.',
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Generate drafts'));
    await pumpUntilFound(tester, find.text('Review drafts'));
    await pumpUntilFound(tester, find.text('Card 1'));

    await tester.tap(find.widgetWithText(TextButton, 'Save'));
    await pumpUntilFound(tester, find.textContaining('Saved'));
    await pumpUntilFound(tester, find.text('Flashhh'));

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
  });
}
