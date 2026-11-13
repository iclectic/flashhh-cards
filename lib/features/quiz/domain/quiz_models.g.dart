// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QuizAttempt _$QuizAttemptFromJson(Map<String, dynamic> json) => _QuizAttempt(
  id: json['id'] as String,
  deckId: json['deckId'] as String?,
  questionStyle: $enumDecode(_$QuizQuestionStyleEnumMap, json['questionStyle']),
  timedSeconds: (json['timedSeconds'] as num?)?.toInt(),
  questionCount: (json['questionCount'] as num?)?.toInt() ?? 0,
  correctCount: (json['correctCount'] as num?)?.toInt() ?? 0,
  startedAt: DateTime.parse(json['startedAt'] as String),
  completedAt: json['completedAt'] == null
      ? null
      : DateTime.parse(json['completedAt'] as String),
);

Map<String, dynamic> _$QuizAttemptToJson(_QuizAttempt instance) =>
    <String, dynamic>{
      'id': instance.id,
      'deckId': instance.deckId,
      'questionStyle': _$QuizQuestionStyleEnumMap[instance.questionStyle]!,
      'timedSeconds': instance.timedSeconds,
      'questionCount': instance.questionCount,
      'correctCount': instance.correctCount,
      'startedAt': instance.startedAt.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
    };

const _$QuizQuestionStyleEnumMap = {
  QuizQuestionStyle.mcq: 'mcq',
  QuizQuestionStyle.shortAnswer: 'short_answer',
  QuizQuestionStyle.mixed: 'mixed',
};

_QuizAnswer _$QuizAnswerFromJson(Map<String, dynamic> json) => _QuizAnswer(
  id: json['id'] as String,
  attemptId: json['attemptId'] as String,
  cardId: json['cardId'] as String,
  questionType: $enumDecode(_$QuizQuestionTypeEnumMap, json['questionType']),
  prompt: json['prompt'] as String,
  correctAnswer: json['correctAnswer'] as String,
  givenAnswer: json['givenAnswer'] as String?,
  choices:
      (json['choices'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  isCorrect: json['isCorrect'] as bool,
  answeredAt: DateTime.parse(json['answeredAt'] as String),
  elapsedMilliseconds: (json['elapsedMilliseconds'] as num?)?.toInt(),
);

Map<String, dynamic> _$QuizAnswerToJson(_QuizAnswer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'attemptId': instance.attemptId,
      'cardId': instance.cardId,
      'questionType': _$QuizQuestionTypeEnumMap[instance.questionType]!,
      'prompt': instance.prompt,
      'correctAnswer': instance.correctAnswer,
      'givenAnswer': instance.givenAnswer,
      'choices': instance.choices,
      'isCorrect': instance.isCorrect,
      'answeredAt': instance.answeredAt.toIso8601String(),
      'elapsedMilliseconds': instance.elapsedMilliseconds,
    };

const _$QuizQuestionTypeEnumMap = {
  QuizQuestionType.mcq: 'mcq',
  QuizQuestionType.shortAnswer: 'short_answer',
};

_QuizAttemptSummary _$QuizAttemptSummaryFromJson(Map<String, dynamic> json) =>
    _QuizAttemptSummary(
      attempt: QuizAttempt.fromJson(json['attempt'] as Map<String, dynamic>),
      answers: (json['answers'] as List<dynamic>)
          .map((e) => QuizAnswer.fromJson(e as Map<String, dynamic>))
          .toList(),
      deckName: json['deckName'] as String?,
    );

Map<String, dynamic> _$QuizAttemptSummaryToJson(_QuizAttemptSummary instance) =>
    <String, dynamic>{
      'attempt': instance.attempt.toJson(),
      'answers': instance.answers.map((e) => e.toJson()).toList(),
      'deckName': instance.deckName,
    };
