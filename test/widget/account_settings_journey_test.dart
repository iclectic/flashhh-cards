import 'package:flashhh_cards/app/app.dart';
import 'package:flashhh_cards/app/dependencies.dart';
import 'package:flashhh_cards/core/analytics/analytics_client.dart';
import 'package:flashhh_cards/core/storage/preferences/preferences_repository.dart';
import 'package:flashhh_cards/core/storage/secure/secure_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/fakes.dart';
import '../support/pump_app.dart';

void main() {
  testWidgets('link email and return to guest from settings', (tester) async {
    tester.view.physicalSize = const Size(800, 2000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);

    final database = widgetMemoryDatabase();
    addTearDown(database.close);
    final clock = FakeClock(DateTime.utc(2026, 6, 15, 12));
    final ids = SequentialIdGenerator();
    final logger = RecordingLogger();
    final secureStore = MemorySecureStore();

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
          analyticsClientProvider.overrideWithValue(
            const NoOpAnalyticsClient(),
          ),
          secureStoreProvider.overrideWithValue(secureStore),
        ],
        child: const FlashhhApp(),
      ),
    );

    await pumpUntilFound(tester, find.text('No decks yet'));
    await tester.tap(find.byTooltip('Settings'));
    await pumpUntilFound(tester, find.text('Guest on this device'));
    await pumpUntilFound(
      tester,
      find.textContaining('Cloud sync is not connected yet'),
    );

    await tester.enterText(
      find.widgetWithText(TextField, 'Email'),
      'study@flashhh.app',
    );
    await tester.enterText(
      find.widgetWithText(TextField, 'Display name'),
      'Study Lead',
    );
    await tester.tap(
      find.widgetWithText(FilledButton, 'Link email on this device'),
    );
    await pumpUntilFound(tester, find.text('study@flashhh.app'));
    expect(find.text('Study Lead'), findsOneWidget);
    expect(secureStore.values.containsKey(SecureStoreKeys.authToken), isTrue);

    await tester.tap(
      find.widgetWithText(OutlinedButton, 'Use as guest on this device'),
    );
    await pumpUntilFound(tester, find.text('Guest on this device'));
    expect(secureStore.values, isEmpty);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
  });
}
