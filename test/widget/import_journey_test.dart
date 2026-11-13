import 'package:flashhh_cards/app/app.dart';
import 'package:flashhh_cards/app/dependencies.dart';
import 'package:flashhh_cards/core/analytics/analytics_client.dart';
import 'package:flashhh_cards/core/storage/preferences/preferences_repository.dart';
import 'package:flashhh_cards/features/ai_generation/domain/document_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/fakes.dart';
import '../support/pump_app.dart';

final class _FakePicker implements DocumentPicker {
  _FakePicker(this.document);

  final PickedDocument? document;

  @override
  Future<PickedDocument?> pickPdf() async => document;
}

void main() {
  testWidgets('importing a PDF records metadata without storing bytes', (
    tester,
  ) async {
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
          documentPickerProvider.overrideWithValue(
            _FakePicker(
              const PickedDocument(
                fileName: 'midterm-notes.pdf',
                byteSize: 12000,
              ),
            ),
          ),
        ],
        child: const FlashhhApp(),
      ),
    );

    await pumpUntilFound(tester, find.byTooltip('Import PDF'));
    await tester.tap(find.byTooltip('Import PDF'));
    await pumpUntilFound(tester, find.text('Nothing imported yet'));
    await tester.tap(find.text('Choose PDF').last);
    await pumpUntilFound(tester, find.text('midterm-notes.pdf'));
    expect(find.textContaining('Ready to generate'), findsOneWidget);

    await tester.tap(find.byTooltip('Remove import'));
    await pumpUntilFound(tester, find.text('Remove this import?'));
    await tester.tap(find.widgetWithText(FilledButton, 'Remove'));
    await pumpUntilFound(tester, find.text('Nothing imported yet'));

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
  });
}
