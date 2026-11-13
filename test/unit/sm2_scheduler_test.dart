import 'package:flashhh_cards/features/study/domain/sm2_scheduler.dart';
import 'package:flashhh_cards/features/study/domain/study_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const starting = SchedulingSnapshot(
    easeFactor: 2.5,
    intervalDays: 0,
    repetitions: 0,
    lapses: 0,
  );
  final now = DateTime.utc(2026, 6, 15, 12);

  test('good on a new card schedules one day later', () {
    final outcome = Sm2Scheduler.schedule(
      current: starting,
      grade: RecallGrade.good,
      now: now,
    );
    expect(outcome.intervalDays, 1);
    expect(outcome.repetitions, 1);
    expect(outcome.success, isTrue);
    expect(outcome.nextReviewAt, DateTime.utc(2026, 6, 16));
  });

  test('again resets repetitions and adds a lapse', () {
    final outcome = Sm2Scheduler.schedule(
      current: const SchedulingSnapshot(
        easeFactor: 2.5,
        intervalDays: 6,
        repetitions: 2,
        lapses: 0,
      ),
      grade: RecallGrade.again,
      now: now,
    );
    expect(outcome.repetitions, 0);
    expect(outcome.lapses, 1);
    expect(outcome.intervalDays, 1);
    expect(outcome.easeFactor, closeTo(2.3, 0.001));
    expect(outcome.success, isFalse);
  });

  test('easy increases ease and applies the easy bonus', () {
    final first = Sm2Scheduler.schedule(
      current: starting,
      grade: RecallGrade.easy,
      now: now,
    );
    expect(first.intervalDays, 4);
    expect(first.easeFactor, closeTo(2.65, 0.001));

    final second = Sm2Scheduler.schedule(
      current: SchedulingSnapshot(
        easeFactor: first.easeFactor,
        intervalDays: first.intervalDays,
        repetitions: first.repetitions,
        lapses: first.lapses,
      ),
      grade: RecallGrade.easy,
      now: now,
    );
    expect(second.intervalDays, greaterThan(first.intervalDays));
  });

  test('ease never drops below 1.3', () {
    final outcome = Sm2Scheduler.schedule(
      current: const SchedulingSnapshot(
        easeFactor: 1.3,
        intervalDays: 1,
        repetitions: 1,
        lapses: 3,
      ),
      grade: RecallGrade.again,
      now: now,
    );
    expect(outcome.easeFactor, Sm2Scheduler.minEase);
  });
}
