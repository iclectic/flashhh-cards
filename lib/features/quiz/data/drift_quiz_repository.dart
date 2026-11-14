import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../core/errors/app_exception.dart';
import '../../../core/storage/database/app_database.dart';
import '../../../core/utilities/app_logger.dart';
import '../../../core/utilities/clock.dart';
import '../../../core/utilities/database_guard.dart';
import '../../../core/utilities/id_generator.dart';
import '../../../core/validation/field_limits.dart';
import '../../flashcards/domain/flashcard.dart';
import '../domain/quiz_answer_grader.dart';
import '../domain/quiz_models.dart';
import '../domain/quiz_repository.dart';

final class DriftQuizRepository implements QuizRepository {
  DriftQuizRepository({
    required AppDatabase database,
    required IdGenerator ids,
    required Clock clock,
    required AppLogger logger,
  }) : _database = database,
       _ids = ids,
       _clock = clock,
       _logger = logger;

  final AppDatabase _database;
  final IdGenerator _ids;
  final Clock _clock;
  final AppLogger _logger;

  @override
  Future<List<Flashcard>> loadCardsForQuiz({
    required String deckId,
    int limit = 200,
  }) {
    final pageSize = limit.clamp(1, FieldLimits.maxPageSize * 4);
    return runDatabase(
      logger: _logger,
      message: 'Quiz cards could not be loaded.',
      action: () async {
        final rows =
            await (_database.select(_database.flashcards)
                  ..where(
                    (card) =>
                        card.deckId.equals(deckId) & card.deletedAt.isNull(),
                  )
                  ..orderBy([
                    (card) => OrderingTerm(
                      expression: card.updatedAt,
                      mode: OrderingMode.desc,
                    ),
                  ])
                  ..limit(pageSize))
                .get();
        return [
          for (final row in rows)
            Flashcard(
              id: row.id,
              deckId: row.deckId,
              question: row.question,
              answer: row.answer,
              createdAt: row.createdAt.toUtc(),
              updatedAt: row.updatedAt.toUtc(),
              source: FlashcardSource.values.byName(row.source),
              difficulty: row.difficulty == null
                  ? null
                  : Difficulty.values.byName(row.difficulty!),
              cardType: FlashcardCardType.values.byName(row.cardType),
            ),
        ];
      },
    );
  }

  @override
  Future<QuizAttempt> startAttempt({
    required String? deckId,
    required QuizQuestionStyle questionStyle,
    required int questionCount,
    int? timedSeconds,
  }) {
    if (questionCount <= 0) {
      throw const ValidationException(
        message: 'A quiz needs at least one question.',
      );
    }
    if (questionCount > FieldLimits.quizQuestionMax) {
      throw ValidationException(
        message:
            'Quizzes can include up to ${FieldLimits.quizQuestionMax} questions.',
      );
    }
    if (timedSeconds != null && timedSeconds <= 0) {
      throw const ValidationException(
        message: 'Timed quizzes need a positive time limit.',
      );
    }
    return runDatabase(
      logger: _logger,
      message: 'The quiz could not be started.',
      action: () async {
        final now = _clock.now();
        final id = _ids.next();
        await _database
            .into(_database.quizAttempts)
            .insert(
              QuizAttemptsCompanion.insert(
                id: id,
                deckId: Value(deckId),
                questionStyle: questionStyle.name,
                timedSeconds: Value(timedSeconds),
                questionCount: Value(questionCount),
                startedAt: now,
              ),
            );
        return QuizAttempt(
          id: id,
          deckId: deckId,
          questionStyle: questionStyle,
          timedSeconds: timedSeconds,
          questionCount: questionCount,
          startedAt: now,
        );
      },
    );
  }

  @override
  Future<QuizAttempt?> findAttempt(String id) {
    return runDatabase(
      logger: _logger,
      message: 'That quiz could not be loaded.',
      action: () async {
        final row =
            await (_database.select(_database.quizAttempts)
                  ..where((attempt) => attempt.id.equals(id)))
                .getSingleOrNull();
        return row == null ? null : _mapAttempt(row);
      },
    );
  }

  @override
  Future<QuizAnswer> recordAnswer({
    required String attemptId,
    required QuizQuestion question,
    required String? givenAnswer,
    int? elapsedMilliseconds,
  }) {
    return runDatabase(
      logger: _logger,
      message: 'The answer could not be saved.',
      action: () async {
        final attempt =
            await (_database.select(_database.quizAttempts)
                  ..where((row) => row.id.equals(attemptId)))
                .getSingleOrNull();
        if (attempt == null) {
          throw const ValidationException(message: 'That quiz no longer exists.');
        }
        if (attempt.completedAt != null) {
          throw const ValidationException(
            message: 'That quiz is already finished.',
          );
        }
        final given = givenAnswer?.trim();
        final isCorrect = given == null || given.isEmpty
            ? false
            : question.type == QuizQuestionType.mcq
            ? given == question.correctAnswer
            : QuizAnswerGrader.matches(
                given: given,
                expected: question.correctAnswer,
              );
        final now = _clock.now();
        final id = _ids.next();
        await _database.transaction(() async {
          await _database
              .into(_database.quizAnswers)
              .insert(
                QuizAnswersCompanion.insert(
                  id: id,
                  attemptId: attemptId,
                  cardId: question.cardId,
                  questionType: question.type.name,
                  prompt: question.prompt,
                  correctAnswer: question.correctAnswer,
                  givenAnswer: Value(given),
                  choicesJson: Value(
                    question.choices.isEmpty
                        ? null
                        : jsonEncode(question.choices),
                  ),
                  isCorrect: isCorrect,
                  answeredAt: now,
                  elapsedMilliseconds: Value(elapsedMilliseconds),
                ),
              );
          if (isCorrect) {
            await (_database.update(
              _database.quizAttempts,
            )..where((row) => row.id.equals(attemptId))).write(
              QuizAttemptsCompanion(
                correctCount: Value(attempt.correctCount + 1),
              ),
            );
          }
        });
        return QuizAnswer(
          id: id,
          attemptId: attemptId,
          cardId: question.cardId,
          questionType: question.type,
          prompt: question.prompt,
          correctAnswer: question.correctAnswer,
          givenAnswer: given,
          choices: question.choices,
          isCorrect: isCorrect,
          answeredAt: now,
          elapsedMilliseconds: elapsedMilliseconds,
        );
      },
    );
  }

  @override
  Future<QuizAttempt> completeAttempt(String attemptId) {
    return runDatabase(
      logger: _logger,
      message: 'The quiz could not be finished.',
      action: () async {
        final existing =
            await (_database.select(_database.quizAttempts)
                  ..where((row) => row.id.equals(attemptId)))
                .getSingleOrNull();
        if (existing == null) {
          throw const ValidationException(message: 'That quiz no longer exists.');
        }
        if (existing.completedAt != null) {
          return _mapAttempt(existing);
        }
        final now = _clock.now();
        await (_database.update(
          _database.quizAttempts,
        )..where((row) => row.id.equals(attemptId))).write(
          QuizAttemptsCompanion(completedAt: Value(now)),
        );
        final updated =
            await (_database.select(_database.quizAttempts)
                  ..where((row) => row.id.equals(attemptId)))
                .getSingle();
        return _mapAttempt(updated);
      },
    );
  }

  @override
  Future<QuizAttemptSummary> loadSummary(String attemptId) {
    return runDatabase(
      logger: _logger,
      message: 'Quiz results could not be loaded.',
      action: () async {
        final attempt =
            await (_database.select(_database.quizAttempts)
                  ..where((row) => row.id.equals(attemptId)))
                .getSingleOrNull();
        if (attempt == null) {
          throw const ValidationException(message: 'That quiz no longer exists.');
        }
        final answers =
            await (_database.select(_database.quizAnswers)
                  ..where((row) => row.attemptId.equals(attemptId))
                  ..orderBy([(row) => OrderingTerm.asc(row.answeredAt)]))
                .get();
        String? deckName;
        final deckId = attempt.deckId;
        if (deckId != null) {
          final deck =
              await (_database.select(_database.decks)
                    ..where((row) => row.id.equals(deckId)))
                  .getSingleOrNull();
          deckName = deck?.name;
        }
        return QuizAttemptSummary(
          attempt: _mapAttempt(attempt),
          answers: answers.map(_mapAnswer).toList(),
          deckName: deckName,
        );
      },
    );
  }

  @override
  Future<List<QuizAttempt>> listRecentAttempts({int limit = 20}) {
    final pageSize = limit.clamp(1, FieldLimits.maxPageSize);
    return runDatabase(
      logger: _logger,
      message: 'Quiz history could not be loaded.',
      action: () async {
        final rows =
            await (_database.select(_database.quizAttempts)
                  ..orderBy([
                    (row) => OrderingTerm(
                      expression: row.startedAt,
                      mode: OrderingMode.desc,
                    ),
                  ])
                  ..limit(pageSize))
                .get();
        return rows.map(_mapAttempt).toList();
      },
    );
  }

  QuizAttempt _mapAttempt(QuizAttemptRow row) {
    return QuizAttempt(
      id: row.id,
      deckId: row.deckId,
      questionStyle: QuizQuestionStyle.values.byName(row.questionStyle),
      timedSeconds: row.timedSeconds,
      questionCount: row.questionCount,
      correctCount: row.correctCount,
      startedAt: row.startedAt.toUtc(),
      completedAt: row.completedAt?.toUtc(),
    );
  }

  QuizAnswer _mapAnswer(QuizAnswerRow row) {
    List<String> choices = const [];
    final raw = row.choicesJson;
    if (raw != null && raw.isNotEmpty) {
      final decoded = jsonDecode(raw);
      if (decoded is List) {
        choices = [
          for (final item in decoded)
            if (item is String) item,
        ];
      }
    }
    return QuizAnswer(
      id: row.id,
      attemptId: row.attemptId,
      cardId: row.cardId,
      questionType: QuizQuestionType.values.byName(row.questionType),
      prompt: row.prompt,
      correctAnswer: row.correctAnswer,
      givenAnswer: row.givenAnswer,
      choices: choices,
      isCorrect: row.isCorrect,
      answeredAt: row.answeredAt.toUtc(),
      elapsedMilliseconds: row.elapsedMilliseconds,
    );
  }
}
