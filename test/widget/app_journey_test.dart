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
  testWidgets(
    'onboarding leads home, settings changes theme, and state is restored',
    (tester) async {
      tester.view.physicalSize = const Size(800, 2000);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);

      final database = widgetMemoryDatabase();
      addTearDown(database.close);
      final clock = FakeClock(DateTime.utc(2026, 6, 15, 12));

      Future<void> launch() {
        return tester.pumpWidget(
          ProviderScope(
            overrides: [
              appDatabaseProvider.overrideWithValue(database),
              clockProvider.overrideWithValue(clock),
              idGeneratorProvider.overrideWithValue(SequentialIdGenerator()),
              analyticsClientProvider.overrideWithValue(
                const NoOpAnalyticsClient(),
              ),
            ],
            child: const FlashhhApp(),
          ),
        );
      }

      await launch();
      await pumpUntilFound(tester, find.text('A calmer way to remember'));

      await tester.tap(find.widgetWithText(FilledButton, 'Next'));
      await tester.pumpAndSettle();
      expect(find.text('Study without a connection'), findsOneWidget);

      await tester.tap(find.widgetWithText(FilledButton, 'Next'));
      await tester.pumpAndSettle();
      expect(find.text('You stay in control'), findsOneWidget);

      await tester.tap(find.widgetWithText(FilledButton, 'Get started'));
      await pumpUntilFound(tester, find.text('No decks yet'));
      expect(find.text('Due today'), findsOneWidget);
      expect(find.text('0'), findsWidgets);

      await tester.tap(find.byTooltip('Settings'));
      await pumpUntilFound(tester, find.text('Appearance'));
      await tester.tap(find.text('Dark'));
      await pumpUntilFound(
        tester,
        find.byWidgetPredicate((widget) {
          return widget is ListTile &&
              widget.selected &&
              widget.title is Text &&
              (widget.title! as Text).data == 'Dark';
        }),
      );
      expect(
        tester.widget<MaterialApp>(find.byType(MaterialApp)).themeMode,
        ThemeMode.dark,
      );

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
      await launch();
      await pumpUntilFound(tester, find.text('No decks yet'));
      expect(find.text('Get started'), findsNothing);
      expect(
        tester.widget<MaterialApp>(find.byType(MaterialApp)).themeMode,
        ThemeMode.dark,
      );
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
    },
  );

  testWidgets('home shows deck progress from saved cards', (tester) async {
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
      await cards.create(
        NewFlashcard(
          deckId: deck.id,
          question: 'What is a cell?',
          answer: 'The basic unit of life.',
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
        ],
        child: const FlashhhApp(),
      ),
    );

    await pumpUntilFound(tester, find.text('Biology'));
    expect(find.text('0 of 1 reviewed'), findsOneWidget);
    expect(find.text('1'), findsWidgets);
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
  });
}
