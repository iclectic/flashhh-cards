/// Consecutive local-calendar-day study streak.
///
/// A day counts when at least one review falls on that local date.
/// If the person has not studied today, yesterday still keeps the streak
/// alive so it does not reset before the day is over.
final class StreakCalculator {
  const StreakCalculator();

  int currentStreak(Iterable<DateTime> reviewedAtUtc, DateTime nowUtc) {
    final days = reviewedAtUtc.map((time) => _dateOnly(time.toLocal())).toSet();
    var cursor = _dateOnly(nowUtc.toLocal());
    if (!days.contains(cursor)) {
      cursor = cursor.subtract(const Duration(days: 1));
      if (!days.contains(cursor)) {
        return 0;
      }
    }
    var streak = 0;
    while (days.contains(cursor)) {
      streak += 1;
      cursor = cursor.subtract(const Duration(days: 1));
    }
    return streak;
  }

  DateTime _dateOnly(DateTime local) =>
      DateTime(local.year, local.month, local.day);
}
