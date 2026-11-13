import 'study_models.dart';

/// Scheduling fields the SM-2 step reads and writes.
final class SchedulingSnapshot {
  const SchedulingSnapshot({
    required this.easeFactor,
    required this.intervalDays,
    required this.repetitions,
    required this.lapses,
  });

  final double easeFactor;
  final int intervalDays;
  final int repetitions;
  final int lapses;
}

/// Result of one graded review.
final class SchedulingOutcome {
  const SchedulingOutcome({
    required this.easeFactor,
    required this.intervalDays,
    required this.repetitions,
    required this.lapses,
    required this.nextReviewAt,
    required this.success,
  });

  final double easeFactor;
  final int intervalDays;
  final int repetitions;
  final int lapses;
  final DateTime nextReviewAt;
  final bool success;
}

/// Anki-style SM-2 over Again / Hard / Good / Easy.
///
/// Ease is clamped to ≥ 1.3. New cards (repetitions == 0) use short first
/// intervals; failed cards reset the repetition streak and add a lapse.
abstract final class Sm2Scheduler {
  static const double minEase = 1.3;
  static const double defaultEase = 2.5;
  static const double easyBonus = 1.3;

  static SchedulingOutcome schedule({
    required SchedulingSnapshot current,
    required RecallGrade grade,
    required DateTime now,
  }) {
    var ease = current.easeFactor <= 0 ? defaultEase : current.easeFactor;
    var interval = current.intervalDays;
    var repetitions = current.repetitions;
    var lapses = current.lapses;
    final success = grade == RecallGrade.good || grade == RecallGrade.easy;

    switch (grade) {
      case RecallGrade.again:
        repetitions = 0;
        lapses += 1;
        interval = 1;
        ease = _clampEase(ease - 0.2);
      case RecallGrade.hard:
        ease = _clampEase(ease - 0.15);
        if (repetitions == 0) {
          interval = 1;
        } else {
          interval = _atLeastOne((interval * 1.2).round());
        }
        repetitions += 1;
      case RecallGrade.good:
        if (repetitions == 0) {
          interval = 1;
        } else if (repetitions == 1) {
          interval = 6;
        } else {
          interval = _atLeastOne((interval * ease).round());
        }
        repetitions += 1;
      case RecallGrade.easy:
        ease = _clampEase(ease + 0.15);
        if (repetitions == 0) {
          interval = 4;
        } else if (repetitions == 1) {
          interval = _atLeastOne((6 * easyBonus).round());
        } else {
          interval = _atLeastOne((interval * ease * easyBonus).round());
        }
        repetitions += 1;
    }

    final nextReviewAt = DateTime.utc(
      now.toUtc().year,
      now.toUtc().month,
      now.toUtc().day,
    ).add(Duration(days: interval));

    return SchedulingOutcome(
      easeFactor: ease,
      intervalDays: interval,
      repetitions: repetitions,
      lapses: lapses,
      nextReviewAt: nextReviewAt,
      success: success,
    );
  }

  static double _clampEase(double value) => value < minEase ? minEase : value;

  static int _atLeastOne(int value) => value < 1 ? 1 : value;
}
