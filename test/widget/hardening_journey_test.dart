import 'package:flashhh_cards/app/app.dart';
import 'package:flashhh_cards/app/dependencies.dart';
import 'package:flashhh_cards/core/analytics/analytics_client.dart';
import 'package:flashhh_cards/core/networking/connectivity_status.dart';
import 'package:flashhh_cards/core/storage/preferences/preferences_repository.dart';
import 'package:flashhh_cards/features/authentication/data/local_account_seeder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/fakes.dart';
import '../support/pump_app.dart';

void main() {
  testWidgets('settings opens privacy policy and import shows offline banner', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(800, 2000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);

    final database = widgetMemoryDatabase();
    addTearDown(database.close);
    final clock = FakeClock(DateTime.utc(2026, 6, 15, 12));
    final ids = SequentialIdGenerator();
    final logger = RecordingLogger();
    final connectivity = FakeConnectivityStatus(NetworkReachability.offline);

    await tester.runAsync(() async {
      await LocalAccountSeeder(
        database: database,
        ids: ids,
        clock: clock,
        logger: logger,
      ).ensureGuestAccount();
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
          connectivityStatusProvider.overrideWithValue(connectivity),
        ],
        child: const FlashhhApp(),
      ),
    );

    await pumpUntilFound(tester, find.byTooltip('Settings'));
    await tester.tap(find.byTooltip('Settings'));
    await pumpUntilFound(tester, find.text('About'));
    await tester.scrollUntilVisible(
      find.text('Privacy policy'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Privacy policy'));
    await pumpUntilFound(tester, find.textContaining('local-first'));
    expect(find.text('Privacy'), findsWidgets);

    await tester.tap(find.byTooltip('Back'));
    await pumpUntilFound(tester, find.text('Settings'));
    await tester.tap(find.byTooltip('Back'));
    await pumpUntilFound(tester, find.byTooltip('Import PDF'));
    await tester.tap(find.byTooltip('Import PDF'));
    await pumpUntilFound(tester, find.textContaining('appear to be offline'));
    expect(find.byIcon(Icons.wifi_off_outlined), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
  });
}
