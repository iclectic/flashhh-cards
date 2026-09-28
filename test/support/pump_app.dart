import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flashhh_cards/app/app.dart';
import 'package:flashhh_cards/app/dependencies.dart';
import 'package:flashhh_cards/core/analytics/analytics_client.dart';
import 'package:flashhh_cards/core/storage/database/app_database.dart';
import 'package:flashhh_cards/core/utilities/clock.dart';
import 'package:flashhh_cards/core/utilities/id_generator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fakes.dart';

Future<void> pumpFlashhh(
  WidgetTester tester, {
  required QueryExecutorFactory openDatabase,
  Clock? clock,
  IdGenerator? ids,
}) {
  return tester.pumpWidget(
    ProviderScope(
      overrides: [
        appDatabaseProvider.overrideWith((ref) {
          final database = openDatabase();
          ref.onDispose(database.close);
          return database;
        }),
        clockProvider.overrideWithValue(
          clock ?? FakeClock(DateTime.utc(2026, 6, 15, 12)),
        ),
        idGeneratorProvider.overrideWithValue(ids ?? SequentialIdGenerator()),
        analyticsClientProvider.overrideWithValue(const NoOpAnalyticsClient()),
      ],
      child: const FlashhhApp(),
    ),
  );
}

typedef QueryExecutorFactory = AppDatabase Function();

AppDatabase memoryDatabase() => AppDatabase(NativeDatabase.memory());

/// In-memory database that drops query streams immediately.
///
/// Drift otherwise keeps a stream alive for one event-loop turn after the last
/// listener leaves. Widget tests fail when that timer is still pending.
AppDatabase widgetMemoryDatabase() {
  return AppDatabase(
    DatabaseConnection(
      NativeDatabase.memory(),
      closeStreamsSynchronously: true,
    ),
  );
}

AppDatabase fileDatabase(File file) => AppDatabase(NativeDatabase(file));

Future<void> pumpUntilFound(WidgetTester tester, Finder finder) async {
  for (var attempt = 0; attempt < 40; attempt++) {
    await tester.pump(const Duration(milliseconds: 50));
    if (finder.evaluate().isNotEmpty) {
      return;
    }
  }
  fail('Did not find $finder');
}
