import '../../../core/storage/database/app_database.dart';
import '../../../core/utilities/app_logger.dart';
import '../../../core/utilities/database_guard.dart';
import '../domain/due_policy.dart';
import '../domain/streak_calculator.dart';
import '../domain/study_models.dart';

final class StudyStatsReader {
  StudyStatsReader({
    required AppDatabase database,
    required AppLogger logger,
    StreakCalculator streakCalculator = const StreakCalculator(),
  }) : _database = database,
       _logger = logger,
       _streakCalculator = streakCalculator;

  final AppDatabase _database;
  final AppLogger _logger;
  final StreakCalculator _streakCalculator;

  /// Projects scheduling columns only, so question and answer text stay out of
  /// the dashboard query.
  Future<DashboardSnapshot> load({required DateTime now}) {
    return runDatabase(
      logger: _logger,
      message: 'Your study summary could not be loaded.',
      action: () async {
        final decks = await (_database.select(
          _database.decks,
        )..where((deck) => deck.deletedAt.isNull())).get();
        final livingDeckIds = {for (final deck in decks) deck.id};
        final cardRows =
            await (_database.selectOnly(_database.flashcards)
                  ..addColumns([
                    _database.flashcards.deckId,
                    _database.flashcards.reviewCount,
                    _database.flashcards.nextReviewAt,
                  ])
                  ..where(_database.flashcards.deletedAt.isNull()))
                .get();
        final reviews =
            await (_database.selectOnly(_database.reviewResults)..addColumns([
                  _database.reviewResults.cardId,
                  _database.reviewResults.reviewedAt,
                ]))
                .get();

        var due = 0;
        final totals = <String, _DeckTally>{};
        for (final deck in decks) {
          totals[deck.id] = _DeckTally(deck.name);
        }
        for (final row in cardRows) {
          final deckId = row.read(_database.flashcards.deckId);
          if (deckId == null || !livingDeckIds.contains(deckId)) {
            continue;
          }
          final tally = totals[deckId];
          if (tally == null) {
            continue;
          }
          tally.total += 1;
          final reviewCount = row.read(_database.flashcards.reviewCount) ?? 0;
          if (reviewCount > 0) {
            tally.reviewed += 1;
          }
          if (DuePolicy.isDue(
            nextReviewAt: row.read(_database.flashcards.nextReviewAt),
            now: now,
          )) {
            due += 1;
          }
        }

        final studiedToday = <String>{};
        final reviewTimes = <DateTime>[];
        for (final row in reviews) {
          final reviewedAt = row.read(_database.reviewResults.reviewedAt);
          final cardId = row.read(_database.reviewResults.cardId);
          if (reviewedAt == null || cardId == null) {
            continue;
          }
          reviewTimes.add(reviewedAt.toUtc());
          if (_sameLocalDay(reviewedAt, now)) {
            studiedToday.add(cardId);
          }
        }

        final progress =
            [
              for (final deck in decks)
                DeckProgress(
                  deckId: deck.id,
                  deckName: deck.name,
                  totalCards: totals[deck.id]?.total ?? 0,
                  reviewedCards: totals[deck.id]?.reviewed ?? 0,
                ),
            ]..sort(
              (a, b) =>
                  a.deckName.toLowerCase().compareTo(b.deckName.toLowerCase()),
            );

        return DashboardSnapshot(
          cardsDue: due,
          cardsStudiedToday: studiedToday.length,
          streak: _streakCalculator.currentStreak(reviewTimes, now.toUtc()),
          decks: progress,
        );
      },
    );
  }

  bool _sameLocalDay(DateTime left, DateTime right) {
    final a = left.toLocal();
    final b = right.toLocal();
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}

final class _DeckTally {
  _DeckTally(this.name);

  final String name;
  int total = 0;
  int reviewed = 0;
}
