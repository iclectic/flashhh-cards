import 'package:flashhh_cards/app/app.dart';
import 'package:flashhh_cards/app/dependencies.dart';
import 'package:flashhh_cards/core/analytics/analytics_client.dart';
import 'package:flashhh_cards/core/storage/preferences/preferences_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/fakes.dart';
import '../support/pump_app.dart';

void main() {
  testWidgets('create, rename, and delete a deck from home', (tester) async {
    final database = widgetMemoryDatabase();
    addTearDown(database.close);
    final clock = FakeClock(DateTime.utc(2026, 6, 15, 12));
    final ids = SequentialIdGenerator();
    final logger = RecordingLogger();

    await tester.runAsync(() async {
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

    await pumpUntilFound(tester, find.text('No decks yet'));
    await tester.tap(find.widgetWithText(FilledButton, 'Create deck'));
    await pumpUntilFound(tester, find.text('New deck'));

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Name'),
      'Interview prep',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Description'),
      'System design basics',
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Save deck'));
    await pumpUntilFound(tester, find.text('No cards yet'));
    expect(find.text('Interview prep'), findsWidgets);
    expect(find.text('System design basics'), findsOneWidget);
    expect(find.text('Add card'), findsWidgets);

    await tester.tap(find.byTooltip('Edit deck'));
    await pumpUntilFound(tester, find.text('Edit deck'));
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Name'),
      'Interview prep v2',
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Save deck'));
    await pumpUntilFound(tester, find.text('0 cards'));
    expect(find.text('Interview prep v2'), findsWidgets);

    await tester.tap(find.byTooltip('Delete deck'));
    await pumpUntilFound(tester, find.text('Delete this deck?'));
    await tester.tap(find.widgetWithText(FilledButton, 'Delete'));
    await pumpUntilFound(tester, find.text('No decks yet'));
    expect(find.text('Interview prep v2'), findsNothing);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
  });
}
