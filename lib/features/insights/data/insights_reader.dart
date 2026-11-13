import '../../../core/storage/database/app_database.dart';
import '../../../core/utilities/app_logger.dart';
import '../../../core/utilities/database_guard.dart';
import '../../study/domain/due_policy.dart';
import '../../study/domain/streak_calculator.dart';
import '../../study/domain/study_models.dart';
import '../domain/insight_models.dart';

/// Offline insights from reviews, quiz answers, and card tags.
///
/// Question/answer text is only loaded for the short weak-card list shown in
/// the UI. Aggregate queries otherwise project counters and ids.
final class InsightsReader {
  InsightsReader({
    required AppDatabase database,
    required AppLogger logger,
    StreakCalculator streakCalculator = const StreakCalculator(),
    this.lookbackDays = 28,
  }) : _database = database,
       _logger = logger,
       _streakCalculator = streakCalculator;

  final AppDatabase _database;
  final AppLogger _logger;
  final StreakCalculator _streakCalculator;
  final int lookbackDays;

  Future<InsightsSnapshot> load({required DateTime now}) {
    return runDatabase(
      logger: _logger,
      message: 'Your insights could not be loaded.',
      action: () async {
        final localNow = now.toLocal();
        final windowStart = DateTime(
          localNow.year,
          localNow.month,
          localNow.day,
        ).subtract(Duration(days: lookbackDays - 1));

        final decks = await (_database.select(
          _database.decks,
        )..where((deck) => deck.deletedAt.isNull())).get();
        final deckNames = {for (final deck in decks) deck.id: deck.name};

        final livingCards =
            await (_database.select(_database.flashcards)
                  ..where((card) => card.deletedAt.isNull()))
                .get();
        final livingCardIds = {for (final card in livingCards) card.id};
        final cardById = {for (final card in livingCards) card.id: card};

        var cardsDue = 0;
        for (final card in livingCards) {
          if (DuePolicy.isDue(nextReviewAt: card.nextReviewAt, now: now)) {
            cardsDue += 1;
          }
        }

        final tags =
            await (_database.select(_database.flashcardTags)).get();
        final tagsByCard = <String, List<String>>{};
        for (final row in tags) {
          if (!livingCardIds.contains(row.cardId)) {
            continue;
          }
          tagsByCard.putIfAbsent(row.cardId, () => []).add(row.tag);
        }

        final reviews = await (_database.select(_database.reviewResults)).get();
        final quizAnswers =
            await (_database.select(_database.quizAnswers)).get();

        final tagAttempts = <String, _Tally>{};
        final cardAttempts = <String, _Tally>{};
        final dayReviews = <DateTime, int>{};
        final dayQuiz = <DateTime, int>{};
        final daySuccess = <DateTime, int>{};
        final dayAttempts = <DateTime, int>{};
        final reviewTimes = <DateTime>[];

        for (final review in reviews) {
          if (!livingCardIds.contains(review.cardId)) {
            continue;
          }
          final reviewedAt = review.reviewedAt.toUtc();
          reviewTimes.add(reviewedAt);
          final day = _localDay(reviewedAt);
          if (!_inWindow(day, windowStart, localNow)) {
            continue;
          }
          dayReviews[day] = (dayReviews[day] ?? 0) + 1;
          dayAttempts[day] = (dayAttempts[day] ?? 0) + 1;
          final miss =
              review.grade == RecallGrade.again.name ||
              review.grade == RecallGrade.hard.name;
          final success = !miss;
          if (success) {
            daySuccess[day] = (daySuccess[day] ?? 0) + 1;
          }
          _bump(cardAttempts, review.cardId, miss: miss);
          for (final tag in tagsByCard[review.cardId] ?? const <String>[]) {
            _bump(tagAttempts, tag, miss: miss);
          }
        }

        for (final answer in quizAnswers) {
          if (!livingCardIds.contains(answer.cardId)) {
            continue;
          }
          final answeredAt = answer.answeredAt.toUtc();
          final day = _localDay(answeredAt);
          if (!_inWindow(day, windowStart, localNow)) {
            continue;
          }
          dayQuiz[day] = (dayQuiz[day] ?? 0) + 1;
          dayAttempts[day] = (dayAttempts[day] ?? 0) + 1;
          final miss = !answer.isCorrect;
          if (!miss) {
            daySuccess[day] = (daySuccess[day] ?? 0) + 1;
          }
          _bump(cardAttempts, answer.cardId, miss: miss);
          for (final tag in tagsByCard[answer.cardId] ?? const <String>[]) {
            _bump(tagAttempts, tag, miss: miss);
          }
        }

        final weakTags =
            [
              for (final entry in tagAttempts.entries)
                if (entry.value.misses > 0)
                  WeakTagInsight(
                    tag: entry.key,
                    attempts: entry.value.attempts,
                    misses: entry.value.misses,
                    accuracy: entry.value.accuracy,
                  ),
            ]..sort((a, b) {
              final byMisses = b.misses.compareTo(a.misses);
              if (byMisses != 0) {
                return byMisses;
              }
              return a.accuracy.compareTo(b.accuracy);
            });

        final weakCards = <WeakCardInsight>[];
        for (final entry in cardAttempts.entries) {
          if (entry.value.misses <= 0) {
            continue;
          }
          final card = cardById[entry.key];
          if (card == null) {
            continue;
          }
          weakCards.add(
            WeakCardInsight(
              cardId: card.id,
              deckId: card.deckId,
              deckName: deckNames[card.deckId] ?? 'Deck',
              prompt: card.question,
              misses: entry.value.misses,
              attempts: entry.value.attempts,
            ),
          );
        }
        weakCards.sort((a, b) {
          final byMisses = b.misses.compareTo(a.misses);
          if (byMisses != 0) {
            return byMisses;
          }
          return a.prompt.toLowerCase().compareTo(b.prompt.toLowerCase());
        });

        final calendar = <StudyDayActivity>[];
        final retention = <RetentionPoint>[];
        for (var offset = 0; offset < lookbackDays; offset++) {
          final day = DateTime(
            localNow.year,
            localNow.month,
            localNow.day,
          ).subtract(Duration(days: lookbackDays - 1 - offset));
          final reviewsCount = dayReviews[day] ?? 0;
          final quizCount = dayQuiz[day] ?? 0;
          calendar.add(
            StudyDayActivity(
              day: day,
              reviewCount: reviewsCount,
              quizAnswerCount: quizCount,
            ),
          );
          final attempts = dayAttempts[day] ?? 0;
          final successes = daySuccess[day] ?? 0;
          retention.add(
            RetentionPoint(
              day: day,
              attempts: attempts,
              successes: successes,
              accuracy: attempts == 0 ? 0 : successes / attempts,
            ),
          );
        }

        final nextActions = <StudyNextAction>[];
        if (cardsDue > 0) {
          nextActions.add(
            StudyNextAction(
              kind: StudyNextKind.studyDue,
              title: cardsDue == 1
                  ? 'Study 1 due card'
                  : 'Study $cardsDue due cards',
              subtitle: 'Clear today’s spaced-repetition queue first.',
              count: cardsDue,
            ),
          );
        }
        if (weakTags.isNotEmpty) {
          final top = weakTags.first;
          nextActions.add(
            StudyNextAction(
              kind: StudyNextKind.reviewWeakTag,
              title: 'Focus on “${top.tag}”',
              subtitle:
                  '${top.misses} recent misses · '
                  '${(top.accuracy * 100).round()}% accuracy',
              tag: top.tag,
              count: top.misses,
            ),
          );
        }
        if (livingCards.isNotEmpty) {
          nextActions.add(
            StudyNextAction(
              kind: StudyNextKind.takeQuiz,
              title: 'Take a quiz',
              subtitle: weakCards.isEmpty
                  ? 'Exam mode stores a score without changing SM-2.'
                  : 'Pressure-test the ${weakCards.length} cards you miss most.',
              count: weakCards.length,
            ),
          );
        } else {
          nextActions.add(
            const StudyNextAction(
              kind: StudyNextKind.addCards,
              title: 'Add cards to a deck',
              subtitle: 'Insights appear after you study or quiz.',
            ),
          );
        }

        return InsightsSnapshot(
          nextActions: nextActions,
          weakTags: weakTags.take(8).toList(),
          weakCards: weakCards.take(8).toList(),
          calendar: calendar,
          retention: retention,
          cardsDue: cardsDue,
          streak: _streakCalculator.currentStreak(reviewTimes, now.toUtc()),
        );
      },
    );
  }

  void _bump(Map<String, _Tally> map, String key, {required bool miss}) {
    final tally = map.putIfAbsent(key, _Tally.new);
    tally.attempts += 1;
    if (miss) {
      tally.misses += 1;
    }
  }

  DateTime _localDay(DateTime value) {
    final local = value.toLocal();
    return DateTime(local.year, local.month, local.day);
  }

  bool _inWindow(DateTime day, DateTime windowStart, DateTime localNow) {
    final end = DateTime(localNow.year, localNow.month, localNow.day);
    return !day.isBefore(windowStart) && !day.isAfter(end);
  }
}

final class _Tally {
  int attempts = 0;
  int misses = 0;

  double get accuracy =>
      attempts == 0 ? 0 : (attempts - misses) / attempts;
}
