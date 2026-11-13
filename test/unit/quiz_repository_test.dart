import 'dart:math';

import 'package:drift/native.dart';
import 'package:flashhh_cards/core/storage/database/app_database.dart';
import 'package:flashhh_cards/features/authentication/data/local_account_seeder.dart';
import 'package:flashhh_cards/features/decks/data/drift_deck_repository.dart';
import 'package:flashhh_cards/features/flashcards/data/drift_flashcard_repository.dart';
import 'package:flashhh_cards/features/flashcards/domain/flashcard.dart';
import 'package:flashhh_cards/features/quiz/data/drift_quiz_repository.dart';
import 'package:flashhh_cards/features/quiz/domain/quiz_models.dart';
import 'package:flashhh_cards/features/quiz/domain/quiz_question_builder.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/fakes.dart';

void main() {
  late AppDatabase database;
  late FakeClock clock;
  late SequentialIdGenerator ids;
  late RecordingLogger logger;
  late DriftQuizRepository quizzes;
  late String deckId;

  setUp(() async {
    database = AppDatabase(NativeDatabase.memory());
    clock = FakeClock(DateTime.utc(2026, 6, 15, 12));
    ids = SequentialIdGenerator();
    logger = RecordingLogger();
    quizzes = DriftQuizRepository(
      database: database,
      ids: ids,
      clock: clock,
      logger: logger,
    );
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
    await cards.create(
      NewFlashcard(
        deckId: deckId,
        question: 'What is CAP?',
        answer: 'Consistency Availability Partition tolerance',
      ),
    );
    await cards.create(
      NewFlashcard(
        deckId: deckId,
        question: 'What is ACID?',
        answer: 'Atomicity Consistency Isolation Durability',
      ),
    );
  });

  tearDown(() => database.close());

  test('records answers and completes a scored attempt', () async {
    final cards = await quizzes.loadCardsForQuiz(deckId: deckId);
    final questions = QuizQuestionBuilder(random: Random(3)).build(
      cards: cards,
      count: 2,
      style: QuizQuestionStyle.shortAnswer,
    );
    final attempt = await quizzes.startAttempt(
      deckId: deckId,
      questionStyle: QuizQuestionStyle.shortAnswer,
      questionCount: questions.length,
      timedSeconds: 300,
    );
    await quizzes.recordAnswer(
      attemptId: attempt.id,
      question: questions[0],
      givenAnswer: questions[0].correctAnswer,
    );
    await quizzes.recordAnswer(
      attemptId: attempt.id,
      question: questions[1],
      givenAnswer: 'wrong',
    );
    final completed = await quizzes.completeAttempt(attempt.id);
    expect(completed.correctCount, 1);
    expect(completed.completedAt, isNotNull);

    final summary = await quizzes.loadSummary(attempt.id);
    expect(summary.answers, hasLength(2));
    expect(summary.deckName, 'Systems');
    expect(summary.answers.where((a) => a.isCorrect), hasLength(1));
  });
}
