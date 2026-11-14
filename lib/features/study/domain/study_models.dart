import 'package:freezed_annotation/freezed_annotation.dart';

part 'study_models.freezed.dart';
part 'study_models.g.dart';

enum RecallGrade { again, hard, good, easy }

/// Spaced review vs ignore-schedule cram. Stored as `.name` in SQLite.
enum StudySessionMode { review, cram }

@freezed
abstract class StudySession with _$StudySession {
  const factory StudySession({
    required String id,
    String? deckId,
    required DateTime startedAt,
    DateTime? completedAt,
    @Default(0) int cardsReviewed,
    @Default(0) int againCount,
    @Default(0) int hardCount,
    @Default(0) int goodCount,
    @Default(0) int easyCount,
    @Default(StudySessionMode.review) StudySessionMode mode,
  }) = _StudySession;

  factory StudySession.fromJson(Map<String, dynamic> json) =>
      _$StudySessionFromJson(json);
}

@freezed
abstract class ReviewResult with _$ReviewResult {
  const factory ReviewResult({
    required String id,
    required String sessionId,
    required String cardId,
    required RecallGrade grade,
    required DateTime reviewedAt,
    int? previousIntervalDays,
    int? newIntervalDays,
    int? elapsedMilliseconds,
  }) = _ReviewResult;

  factory ReviewResult.fromJson(Map<String, dynamic> json) =>
      _$ReviewResultFromJson(json);
}

@freezed
abstract class DeckProgress with _$DeckProgress {
  const factory DeckProgress({
    required String deckId,
    required String deckName,
    required int totalCards,
    required int reviewedCards,
  }) = _DeckProgress;

  factory DeckProgress.fromJson(Map<String, dynamic> json) =>
      _$DeckProgressFromJson(json);
}

@freezed
abstract class DashboardSnapshot with _$DashboardSnapshot {
  const factory DashboardSnapshot({
    required int cardsDue,
    required int cardsStudiedToday,
    required int streak,
    required List<DeckProgress> decks,
  }) = _DashboardSnapshot;

  factory DashboardSnapshot.fromJson(Map<String, dynamic> json) =>
      _$DashboardSnapshotFromJson(json);
}

/// Riverpod / route key for a study sitting.
final class StudySessionArgs {
  const StudySessionArgs({
    this.deckId,
    this.mode = StudySessionMode.review,
    this.typedAnswer = false,
  });

  final String? deckId;
  final StudySessionMode mode;
  final bool typedAnswer;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is StudySessionArgs &&
            deckId == other.deckId &&
            mode == other.mode &&
            typedAnswer == other.typedAnswer;
  }

  @override
  int get hashCode => Object.hash(deckId, mode, typedAnswer);
}
