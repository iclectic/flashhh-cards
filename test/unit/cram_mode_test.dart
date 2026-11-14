import 'package:flashhh_cards/features/authentication/data/local_account_seeder.dart';
import 'package:flashhh_cards/features/decks/data/drift_deck_repository.dart';
import 'package:flashhh_cards/features/flashcards/data/drift_flashcard_repository.dart';
import 'package:flashhh_cards/features/flashcards/domain/flashcard.dart';
import 'package:flashhh_cards/features/study/data/drift_study_repository.dart';
import 'package:flashhh_cards/features/study/domain/study_models.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/fakes.dart';
import '../support/pump_app.dart';

void main() {
  test('cram loads scheduled cards and does not rewrite SM-2', () async {
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
    ).createDeck(ownerId: user.id, name: 'Cram', description: '');
    final cards = DriftFlashcardRepository(
      database: database,
      ids: ids,
      clock: clock,
      logger: logger,
    );
    final first = await cards.create(
      NewFlashcard(deckId: deck.id, question: 'Q1', answer: 'A1'),
    );
    await cards.create(
      NewFlashcard(deckId: deck.id, question: 'Q2', answer: 'A2'),
    );

    final study = DriftStudyRepository(
      database: database,
      ids: ids,
      clock: clock,
      logger: logger,
    );

    // Schedule the first card out of the due queue.
    final reviewSession = await study.startSession(deckId: deck.id);
    final graded = await study.gradeCard(
      sessionId: reviewSession.id,
      cardId: first.id,
      grade: RecallGrade.good,
    );
    await study.completeSession(reviewSession.id);
    expect(graded.card.nextReviewAt, isNotNull);
    expect(graded.card.intervalDays, 1);

    final due = await study.loadDueCards(deckId: deck.id, now: clock.now());
    expect(due, hasLength(1));
    expect(due.single.question, 'Q2');

    final cramQueue = await study.loadStudyQueue(
      deckId: deck.id,
      now: clock.now(),
      mode: StudySessionMode.cram,
    );
    expect(cramQueue, hasLength(2));

    final cramSession = await study.startSession(
      deckId: deck.id,
      mode: StudySessionMode.cram,
    );
    expect(cramSession.mode, StudySessionMode.cram);

    final cramGraded = await study.gradeCard(
      sessionId: cramSession.id,
      cardId: first.id,
      grade: RecallGrade.again,
    );
    await study.completeSession(cramSession.id);

    expect(cramGraded.card.nextReviewAt, graded.card.nextReviewAt);
    expect(cramGraded.card.intervalDays, 1);
    expect(cramGraded.card.easeFactor, graded.card.easeFactor);
    expect(cramGraded.card.reviewCount, graded.card.reviewCount);
  });

  test('persists cloze and reverse card types', () async {
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
    ).createDeck(ownerId: user.id, name: 'Types', description: '');
    final cards = DriftFlashcardRepository(
      database: database,
      ids: ids,
      clock: clock,
      logger: logger,
    );

    final cloze = await cards.create(
      NewFlashcard(
        deckId: deck.id,
        question: 'The {{c1::sky}} is blue.',
        answer: '',
        cardType: FlashcardCardType.cloze,
      ),
    );
    expect(cloze.cardType, FlashcardCardType.cloze);
    expect(cloze.answer, 'sky');

    final reverse = await cards.create(
      NewFlashcard(
        deckId: deck.id,
        question: 'Front',
        answer: 'Back',
        cardType: FlashcardCardType.reverse,
      ),
    );
    expect(reverse.cardType, FlashcardCardType.reverse);

    final loaded = await cards.findById(cloze.id);
    expect(loaded?.cardType, FlashcardCardType.cloze);
  });
}
