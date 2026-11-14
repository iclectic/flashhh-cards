import 'package:drift/drift.dart';

import '../../../core/errors/app_exception.dart';
import '../../../core/storage/database/app_database.dart';
import '../../../core/utilities/app_logger.dart';
import '../../../core/utilities/clock.dart';
import '../../../core/utilities/database_guard.dart';
import '../../../core/utilities/id_generator.dart';
import '../../../core/validation/field_limits.dart';
import '../../flashcards/domain/flashcard.dart';
import '../domain/due_policy.dart';
import '../domain/sm2_scheduler.dart';
import '../domain/study_models.dart';
import '../domain/study_repository.dart';

final class DriftStudyRepository implements StudyRepository {
  DriftStudyRepository({
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
  Future<List<Flashcard>> loadDueCards({
    String? deckId,
    required DateTime now,
    int limit = 50,
  }) {
    return loadStudyQueue(
      deckId: deckId,
      now: now,
      mode: StudySessionMode.review,
      limit: limit,
    );
  }

  @override
  Future<List<Flashcard>> loadStudyQueue({
    String? deckId,
    required DateTime now,
    StudySessionMode mode = StudySessionMode.review,
    int limit = 50,
  }) {
    final pageSize = limit.clamp(1, FieldLimits.maxPageSize);
    return runDatabase(
      logger: _logger,
      message: 'Study cards could not be loaded.',
      action: () async {
        final livingDeckIds = await _livingDeckIds();
        final stmt = _database.select(_database.flashcards)
          ..where((card) => card.deletedAt.isNull());
        if (deckId != null) {
          stmt.where((card) => card.deckId.equals(deckId));
        }
        stmt.orderBy([
          if (mode == StudySessionMode.review)
            (card) => OrderingTerm(
              expression: card.nextReviewAt,
              mode: OrderingMode.asc,
              nulls: NullsOrder.first,
            ),
          (card) => OrderingTerm(expression: card.createdAt),
        ]);
        final rows = await stmt.get();
        final queue = <FlashcardRow>[];
        for (final row in rows) {
          if (!livingDeckIds.contains(row.deckId)) {
            continue;
          }
          if (mode == StudySessionMode.review &&
              !DuePolicy.isDue(nextReviewAt: row.nextReviewAt, now: now)) {
            continue;
          }
          queue.add(row);
          if (queue.length >= pageSize) {
            break;
          }
        }
        return _withTags(queue);
      },
    );
  }

  @override
  Future<StudySession> startSession({
    String? deckId,
    StudySessionMode mode = StudySessionMode.review,
  }) {
    return runDatabase(
      logger: _logger,
      message: 'The study session could not be started.',
      action: () async {
        if (deckId != null) {
          await _requireDeck(deckId);
        }
        final id = _ids.next();
        final now = _clock.now();
        await _database
            .into(_database.studySessions)
            .insert(
              StudySessionsCompanion.insert(
                id: id,
                deckId: Value(deckId),
                startedAt: now,
                mode: Value(mode.name),
              ),
            );
        final session = await findSession(id);
        if (session == null) {
          throw const DatabaseException(
            message: 'The study session could not be started.',
          );
        }
        return session;
      },
    );
  }

  @override
  Future<StudySession?> findSession(String id) {
    return runDatabase(
      logger: _logger,
      message: 'That study session could not be loaded.',
      action: () async {
        final row =
            await (_database.select(_database.studySessions)
                  ..where((session) => session.id.equals(id)))
                .getSingleOrNull();
        return row == null ? null : _mapSession(row);
      },
    );
  }

  @override
  Future<GradedReview> gradeCard({
    required String sessionId,
    required String cardId,
    required RecallGrade grade,
    int? elapsedMilliseconds,
  }) {
    return runDatabase(
      logger: _logger,
      message: 'That review could not be saved.',
      action: () async {
        final sessionRow =
            await (_database.select(_database.studySessions)
                  ..where((session) => session.id.equals(sessionId)))
                .getSingleOrNull();
        if (sessionRow == null || sessionRow.completedAt != null) {
          throw const ValidationException(
            message: 'That study session is no longer open.',
          );
        }
        final cardRow =
            await (_database.select(_database.flashcards)..where(
                  (card) => card.id.equals(cardId) & card.deletedAt.isNull(),
                ))
                .getSingleOrNull();
        if (cardRow == null) {
          throw const ValidationException(
            message: 'That flashcard no longer exists.',
          );
        }

        final now = _clock.now();
        final previousInterval = cardRow.intervalDays;
        final mode = StudySessionMode.values.byName(sessionRow.mode);
        final applySchedule = mode == StudySessionMode.review;
        final outcome = applySchedule
            ? Sm2Scheduler.schedule(
                current: SchedulingSnapshot(
                  easeFactor: cardRow.easeFactorMillis / 1000,
                  intervalDays: cardRow.intervalDays,
                  repetitions: cardRow.repetitions,
                  lapses: cardRow.lapses,
                ),
                grade: grade,
                now: now,
              )
            : null;
        final reviewId = _ids.next();
        final newInterval = outcome?.intervalDays ?? previousInterval;

        await _database.transaction(() async {
          if (applySchedule && outcome != null) {
            await (_database.update(
              _database.flashcards,
            )..where((card) => card.id.equals(cardId))).write(
              FlashcardsCompanion(
                lastReviewedAt: Value(now),
                nextReviewAt: Value(outcome.nextReviewAt),
                reviewCount: Value(cardRow.reviewCount + 1),
                successCount: Value(
                  cardRow.successCount + (outcome.success ? 1 : 0),
                ),
                failureCount: Value(
                  cardRow.failureCount + (outcome.success ? 0 : 1),
                ),
                easeFactorMillis: Value(
                  (outcome.easeFactor * 1000).round(),
                ),
                intervalDays: Value(outcome.intervalDays),
                repetitions: Value(outcome.repetitions),
                lapses: Value(outcome.lapses),
                updatedAt: Value(now),
              ),
            );
          }

          await _database
              .into(_database.reviewResults)
              .insert(
                ReviewResultsCompanion.insert(
                  id: reviewId,
                  sessionId: sessionId,
                  cardId: cardId,
                  grade: grade.name,
                  reviewedAt: now,
                  previousIntervalDays: Value(previousInterval),
                  newIntervalDays: Value(newInterval),
                  elapsedMilliseconds: Value(elapsedMilliseconds),
                ),
              );

          await (_database.update(
            _database.studySessions,
          )..where((session) => session.id.equals(sessionId))).write(
            StudySessionsCompanion(
              cardsReviewed: Value(sessionRow.cardsReviewed + 1),
              againCount: Value(
                sessionRow.againCount +
                    (grade == RecallGrade.again ? 1 : 0),
              ),
              hardCount: Value(
                sessionRow.hardCount + (grade == RecallGrade.hard ? 1 : 0),
              ),
              goodCount: Value(
                sessionRow.goodCount + (grade == RecallGrade.good ? 1 : 0),
              ),
              easyCount: Value(
                sessionRow.easyCount + (grade == RecallGrade.easy ? 1 : 0),
              ),
            ),
          );
        });

        final session = await findSession(sessionId);
        final card = await _livingCard(cardId);
        if (session == null || card == null) {
          throw const DatabaseException(
            message: 'That review could not be saved.',
          );
        }
        return GradedReview(
          session: session,
          result: ReviewResult(
            id: reviewId,
            sessionId: sessionId,
            cardId: cardId,
            grade: grade,
            reviewedAt: now.toUtc(),
            previousIntervalDays: previousInterval,
            newIntervalDays: newInterval,
            elapsedMilliseconds: elapsedMilliseconds,
          ),
          card: card,
        );
      },
    );
  }

  @override
  Future<StudySession> completeSession(String sessionId) {
    return runDatabase(
      logger: _logger,
      message: 'The study session could not be finished.',
      action: () async {
        final existing =
            await (_database.select(_database.studySessions)
                  ..where((session) => session.id.equals(sessionId)))
                .getSingleOrNull();
        if (existing == null) {
          throw const ValidationException(
            message: 'That study session no longer exists.',
          );
        }
        if (existing.completedAt == null) {
          await (_database.update(
            _database.studySessions,
          )..where((session) => session.id.equals(sessionId))).write(
            StudySessionsCompanion(completedAt: Value(_clock.now())),
          );
        }
        final session = await findSession(sessionId);
        if (session == null) {
          throw const DatabaseException(
            message: 'The study session could not be finished.',
          );
        }
        return session;
      },
    );
  }

  Future<Set<String>> _livingDeckIds() async {
    final decks = await (_database.select(
      _database.decks,
    )..where((deck) => deck.deletedAt.isNull())).get();
    return {for (final deck in decks) deck.id};
  }

  Future<void> _requireDeck(String id) async {
    final deck =
        await (_database.select(_database.decks)
              ..where((row) => row.id.equals(id) & row.deletedAt.isNull()))
            .getSingleOrNull();
    if (deck == null) {
      throw const ValidationException(message: 'That deck no longer exists.');
    }
  }

  Future<Flashcard?> _livingCard(String id) async {
    final row =
        await (_database.select(_database.flashcards)
              ..where((card) => card.id.equals(id) & card.deletedAt.isNull()))
            .getSingleOrNull();
    if (row == null) {
      return null;
    }
    return (await _withTags([row])).single;
  }

  Future<List<Flashcard>> _withTags(List<FlashcardRow> rows) async {
    if (rows.isEmpty) {
      return const [];
    }
    final ids = rows.map((row) => row.id).toList();
    final tagRows = await (_database.select(
      _database.flashcardTags,
    )..where((row) => row.cardId.isIn(ids))).get();
    final grouped = <String, List<String>>{};
    for (final row in tagRows) {
      grouped.putIfAbsent(row.cardId, () => []).add(row.tag);
    }
    for (final tags in grouped.values) {
      tags.sort();
    }
    return [
      for (final row in rows) _mapCard(row, grouped[row.id] ?? const []),
    ];
  }

  Flashcard _mapCard(FlashcardRow row, List<String> tags) {
    return Flashcard(
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
      tags: tags,
      lastReviewedAt: row.lastReviewedAt?.toUtc(),
      nextReviewAt: row.nextReviewAt?.toUtc(),
      reviewCount: row.reviewCount,
      successCount: row.successCount,
      failureCount: row.failureCount,
      easeFactor: row.easeFactorMillis / 1000,
      intervalDays: row.intervalDays,
      repetitions: row.repetitions,
      lapses: row.lapses,
      deletedAt: row.deletedAt?.toUtc(),
    );
  }

  StudySession _mapSession(StudySessionRow row) {
    return StudySession(
      id: row.id,
      deckId: row.deckId,
      startedAt: row.startedAt.toUtc(),
      completedAt: row.completedAt?.toUtc(),
      cardsReviewed: row.cardsReviewed,
      againCount: row.againCount,
      hardCount: row.hardCount,
      goodCount: row.goodCount,
      easyCount: row.easyCount,
      mode: StudySessionMode.values.byName(row.mode),
    );
  }
}
