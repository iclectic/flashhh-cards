import 'package:flashhh_cards/app/app.dart';
import 'package:flashhh_cards/app/dependencies.dart';
import 'package:flashhh_cards/core/analytics/analytics_client.dart';
import 'package:flashhh_cards/core/storage/preferences/preferences_repository.dart';
import 'package:flashhh_cards/features/authentication/data/local_account_seeder.dart';
import 'package:flashhh_cards/features/decks/data/drift_deck_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/fakes.dart';
import '../support/pump_app.dart';

void main() {
  testWidgets('add, edit, duplicate, and delete a card in a deck', (
    tester,
  ) async {
    final database = widgetMemoryDatabase();
    addTearDown(database.close);
    final clock = FakeClock(DateTime.utc(2026, 6, 15, 12));
    final ids = SequentialIdGenerator();
    final logger = RecordingLogger();
    late final String deckId;

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
      ).createDeck(
        ownerId: user.id,
        name: 'Algorithms',
        description: '',
      );
      deckId = deck.id;
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

    await pumpUntilFound(tester, find.text('Algorithms'));
    await tester.tap(find.text('Algorithms'));
    await pumpUntilFound(tester, find.text('No cards yet'));

    await tester.tap(find.text('Add card').last);
    await pumpUntilFound(tester, find.byType(TextFormField));
    expect(find.text('New card'), findsOneWidget);
    final newFields = find.byType(TextFormField);
    expect(newFields, findsNWidgets(3));
    await tester.enterText(newFields.at(0), 'What is Big O?');
    await tester.enterText(newFields.at(1), 'An upper bound on growth.');
    await tester.enterText(newFields.at(2), 'complexity');
    await tester.tap(find.widgetWithText(TextButton, 'Save card'));
    await pumpUntilFound(tester, find.text('1 card'));
    expect(find.text('What is Big O?'), findsOneWidget);
    expect(find.text('complexity'), findsOneWidget);

    await tester.tap(find.text('What is Big O?'));
    await pumpUntilFound(tester, find.text('Edit card'));
    await pumpUntilFound(tester, find.byType(TextFormField));
    final editFields = find.byType(TextFormField);
    expect(editFields, findsNWidgets(3));
    await tester.enterText(editFields.at(0), 'Define Big O notation');
    await tester.tap(find.widgetWithText(TextButton, 'Save card'));
    await pumpUntilFound(tester, find.text('Define Big O notation'));

    await tester.tap(find.byTooltip('Card actions'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Duplicate').hitTestable());
    await pumpUntilFound(tester, find.text('Card duplicated.'));
    expect(find.text('Define Big O notation'), findsNWidgets(2));

    await tester.tap(find.byTooltip('Card actions').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete').hitTestable());
    await pumpUntilFound(tester, find.text('Delete this card?'));
    await tester.tap(find.widgetWithText(FilledButton, 'Delete'));
    await tester.pumpAndSettle();
    expect(find.text('Define Big O notation'), findsOneWidget);

    expect(deckId, isNotEmpty);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
  });
}
