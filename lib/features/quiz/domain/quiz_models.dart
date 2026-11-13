import 'package:freezed_annotation/freezed_annotation.dart';

part 'quiz_models.freezed.dart';
part 'quiz_models.g.dart';

@JsonEnum(fieldRename: FieldRename.snake)
enum QuizQuestionStyle { mcq, shortAnswer, mixed }

@JsonEnum(fieldRename: FieldRename.snake)
enum QuizQuestionType { mcq, shortAnswer }

@freezed
abstract class QuizAttempt with _$QuizAttempt {
  const factory QuizAttempt({
    required String id,
    String? deckId,
    required QuizQuestionStyle questionStyle,
    int? timedSeconds,
    @Default(0) int questionCount,
    @Default(0) int correctCount,
    required DateTime startedAt,
    DateTime? completedAt,
  }) = _QuizAttempt;

  factory QuizAttempt.fromJson(Map<String, dynamic> json) =>
      _$QuizAttemptFromJson(json);
}

@freezed
abstract class QuizAnswer with _$QuizAnswer {
  const factory QuizAnswer({
    required String id,
    required String attemptId,
    required String cardId,
    required QuizQuestionType questionType,
    required String prompt,
    required String correctAnswer,
    String? givenAnswer,
    @Default(<String>[]) List<String> choices,
    required bool isCorrect,
    required DateTime answeredAt,
    int? elapsedMilliseconds,
  }) = _QuizAnswer;

  factory QuizAnswer.fromJson(Map<String, dynamic> json) =>
      _$QuizAnswerFromJson(json);
}

/// In-memory question produced before the person answers.
final class QuizQuestion {
  const QuizQuestion({
    required this.cardId,
    required this.prompt,
    required this.correctAnswer,
    required this.type,
    this.choices = const [],
  });

  final String cardId;
  final String prompt;
  final String correctAnswer;
  final QuizQuestionType type;
  final List<String> choices;
}

@freezed
abstract class QuizAttemptSummary with _$QuizAttemptSummary {
  const factory QuizAttemptSummary({
    required QuizAttempt attempt,
    required List<QuizAnswer> answers,
    String? deckName,
  }) = _QuizAttemptSummary;

  factory QuizAttemptSummary.fromJson(Map<String, dynamic> json) =>
      _$QuizAttemptSummaryFromJson(json);
}
