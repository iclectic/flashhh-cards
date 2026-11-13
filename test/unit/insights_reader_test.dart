import 'package:drift/native.dart';
import 'package:flashhh_cards/core/storage/database/app_database.dart';
import 'package:flashhh_cards/features/authentication/data/local_account_seeder.dart';
import 'package:flashhh_cards/features/decks/data/drift_deck_repository.dart';
import 'package:flashhh_cards/features/flashcards/data/drift_flashcard_repository.dart';
import 'package:flashhh_cards/features/flashcards/domain/flashcard.dart';
import 'package:flashhh_cards/features/insights/data/insights_reader.dart';
import 'package:flashhh_cards/features/insights/domain/insight_models.dart';
import 'package:flashhh_cards/features/quiz/data/drift_quiz_repository.dart';
import 'package:flashhh_cards/features/quiz/domain/quiz_models.dart';
import 'package:flashhh_cards/features/study/data/drift_study_repository.dart';
import 'package:flashhh_cards/features/study/domain/study_models.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/fakes.dart';

void main() {
  late AppDatabase database;
  late FakeClock clock;
  late SequentialIdGenerator ids;
  late RecordingLogger logger;
  late InsightsReader insights;
  late String deckId;
  late String cardId;

  setUp(() async {
    database = AppDatabase(NativeDatabase.memory());
    clock = FakeClock(DateTime.utc(2026, 6, 15, 12));
    ids = SequentialIdGenerator();
    logger = RecordingLogger();
    insights = InsightsReader(database: database, logger: logger);
    final owner = await LocalAccountSeeder(
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
      ownerId: owner.id,
      name: 'Systems',
      description: '',
    );
    deckId = deck.id;
    final card = await cards.create(
      NewFlashcard(
        deckId: deckId,
        question: 'What is CAP?',
        answer: 'Consistency Availability Partition tolerance',
        tags: const ['distributed', 'theory'],
      ),
    );
    cardId = card.id;
    await cards.create(
      NewFlashcard(
        deckId: deckId,
        question: 'What is BASE?',
        answer: 'Basically Available Soft state Eventual consistency',
        tags: const ['distributed'],
      ),
    );
  });

  tearDown(() => database.close());

  test('surfaces weak tags, calendar activity, and next actions', () async {
    final study = DriftStudyRepository(
      database: database,
      ids: ids,
      clock: clock,
      logger: logger,
    );
    final session = await study.startSession(deckId: deckId);
    await study.gradeCard(
      sessionId: session.id,
      cardId: cardId,
      grade: RecallGrade.again,
    );
    await study.completeSession(session.id);

    final quizzes = DriftQuizRepository(
      database: database,
      ids: ids,
      clock: clock,
      logger: logger,
    );
    final attempt = await quizzes.startAttempt(
      deckId: deckId,
      questionStyle: QuizQuestionStyle.shortAnswer,
      questionCount: 1,
    );
    await quizzes.recordAnswer(
      attemptId: attempt.id,
      question: QuizQuestion(
        cardId: cardId,
        prompt: 'What is CAP?',
        correctAnswer: 'Consistency Availability Partition tolerance',
        type: QuizQuestionType.shortAnswer,
      ),
      givenAnswer: 'wrong',
    );
    await quizzes.completeAttempt(attempt.id);

    final snapshot = await insights.load(now: clock.now());
    expect(snapshot.cardsDue, greaterThanOrEqualTo(1));
    expect(snapshot.weakTags.map((tag) => tag.tag), contains('distributed'));
    expect(snapshot.weakCards, isNotEmpty);
    expect(snapshot.weakCards.first.prompt, contains('CAP'));
    expect(
      snapshot.calendar.any(
        (day) => day.reviewCount + day.quizAnswerCount > 0,
      ),
      isTrue,
    );
    expect(
      snapshot.nextActions.map((action) => action.kind),
      containsAll([
        StudyNextKind.studyDue,
        StudyNextKind.reviewWeakTag,
        StudyNextKind.takeQuiz,
      ]),
    );
  });
}
