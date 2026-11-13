import 'package:freezed_annotation/freezed_annotation.dart';

part 'insight_models.freezed.dart';
part 'insight_models.g.dart';

enum StudyNextKind { studyDue, reviewWeakTag, takeQuiz, addCards }

@freezed
abstract class StudyNextAction with _$StudyNextAction {
  const factory StudyNextAction({
    required StudyNextKind kind,
    required String title,
    required String subtitle,
    String? tag,
    String? deckId,
    @Default(0) int count,
  }) = _StudyNextAction;

  factory StudyNextAction.fromJson(Map<String, dynamic> json) =>
      _$StudyNextActionFromJson(json);
}

@freezed
abstract class WeakTagInsight with _$WeakTagInsight {
  const factory WeakTagInsight({
    required String tag,
    required int attempts,
    required int misses,
    required double accuracy,
  }) = _WeakTagInsight;

  factory WeakTagInsight.fromJson(Map<String, dynamic> json) =>
      _$WeakTagInsightFromJson(json);
}

@freezed
abstract class WeakCardInsight with _$WeakCardInsight {
  const factory WeakCardInsight({
    required String cardId,
    required String deckId,
    required String deckName,
    required String prompt,
    required int misses,
    required int attempts,
  }) = _WeakCardInsight;

  factory WeakCardInsight.fromJson(Map<String, dynamic> json) =>
      _$WeakCardInsightFromJson(json);
}

@freezed
abstract class StudyDayActivity with _$StudyDayActivity {
  const factory StudyDayActivity({
    /// Local calendar day at midnight.
    required DateTime day,
    required int reviewCount,
    required int quizAnswerCount,
  }) = _StudyDayActivity;

  factory StudyDayActivity.fromJson(Map<String, dynamic> json) =>
      _$StudyDayActivityFromJson(json);
}

@freezed
abstract class RetentionPoint with _$RetentionPoint {
  const factory RetentionPoint({
    required DateTime day,
    required int attempts,
    required int successes,
    required double accuracy,
  }) = _RetentionPoint;

  factory RetentionPoint.fromJson(Map<String, dynamic> json) =>
      _$RetentionPointFromJson(json);
}

@freezed
abstract class InsightsSnapshot with _$InsightsSnapshot {
  const factory InsightsSnapshot({
    required List<StudyNextAction> nextActions,
    required List<WeakTagInsight> weakTags,
    required List<WeakCardInsight> weakCards,
    required List<StudyDayActivity> calendar,
    required List<RetentionPoint> retention,
    required int cardsDue,
    required int streak,
  }) = _InsightsSnapshot;

  factory InsightsSnapshot.fromJson(Map<String, dynamic> json) =>
      _$InsightsSnapshotFromJson(json);
}
