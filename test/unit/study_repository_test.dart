import 'package:flashhh_cards/features/authentication/data/local_account_seeder.dart';
import 'package:flashhh_cards/features/decks/data/drift_deck_repository.dart';
import 'package:flashhh_cards/features/flashcards/data/drift_flashcard_repository.dart';
import 'package:flashhh_cards/features/flashcards/domain/flashcard.dart';
import 'package:flashhh_cards/features/study/data/drift_study_repository.dart';
import 'package:flashhh_cards/features/study/data/study_stats_reader.dart';
import 'package:flashhh_cards/features/study/domain/study_models.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/fakes.dart';
import '../support/pump_app.dart';

void main() {
  test('grading a card schedules it out of the due queue', () async {
    final database = memoryDatabase();
    addTearDown(database.close);
    final clock = FakeClock(DateTime.utc(2026, 6, 15, 12));
    final ids = SequentialIdGenerator();
    final logger = RecordingLogger();

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
    ).createDeck(ownerId: user.id, name: 'Bio', description: '');
    final card = await DriftFlashcardRepository(
      database: database,
      ids: ids,
      clock: clock,
      logger: logger,
    ).create(
      NewFlashcard(
        deckId: deck.id,
        question: 'Q',
        answer: 'A',
      ),
    );
    final study = DriftStudyRepository(
      database: database,
      ids: ids,
      clock: clock,
      logger: logger,
    );

    final before = await StudyStatsReader(
      database: database,
      logger: logger,
    ).load(now: clock.now());
    expect(before.cardsDue, 1);

    final session = await study.startSession(deckId: deck.id);
    final graded = await study.gradeCard(
      sessionId: session.id,
      cardId: card.id,
      grade: RecallGrade.good,
    );
    await study.completeSession(session.id);

    expect(graded.card.nextReviewAt, isNotNull);
    expect(graded.card.intervalDays, 1);
    expect(graded.card.reviewCount, 1);

    final due = await study.loadDueCards(now: clock.now());
    expect(due, isEmpty);

    final after = await StudyStatsReader(
      database: database,
      logger: logger,
    ).load(now: clock.now());
    expect(after.cardsDue, 0);
    expect(after.cardsStudiedToday, 1);
  });
}
