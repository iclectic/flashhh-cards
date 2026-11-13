// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insight_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StudyNextAction _$StudyNextActionFromJson(Map<String, dynamic> json) =>
    _StudyNextAction(
      kind: $enumDecode(_$StudyNextKindEnumMap, json['kind']),
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      tag: json['tag'] as String?,
      deckId: json['deckId'] as String?,
      count: (json['count'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$StudyNextActionToJson(_StudyNextAction instance) =>
    <String, dynamic>{
      'kind': _$StudyNextKindEnumMap[instance.kind]!,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'tag': instance.tag,
      'deckId': instance.deckId,
      'count': instance.count,
    };

const _$StudyNextKindEnumMap = {
  StudyNextKind.studyDue: 'studyDue',
  StudyNextKind.reviewWeakTag: 'reviewWeakTag',
  StudyNextKind.takeQuiz: 'takeQuiz',
  StudyNextKind.addCards: 'addCards',
};

_WeakTagInsight _$WeakTagInsightFromJson(Map<String, dynamic> json) =>
    _WeakTagInsight(
      tag: json['tag'] as String,
      attempts: (json['attempts'] as num).toInt(),
      misses: (json['misses'] as num).toInt(),
      accuracy: (json['accuracy'] as num).toDouble(),
    );

Map<String, dynamic> _$WeakTagInsightToJson(_WeakTagInsight instance) =>
    <String, dynamic>{
      'tag': instance.tag,
      'attempts': instance.attempts,
      'misses': instance.misses,
      'accuracy': instance.accuracy,
    };

_WeakCardInsight _$WeakCardInsightFromJson(Map<String, dynamic> json) =>
    _WeakCardInsight(
      cardId: json['cardId'] as String,
      deckId: json['deckId'] as String,
      deckName: json['deckName'] as String,
      prompt: json['prompt'] as String,
      misses: (json['misses'] as num).toInt(),
      attempts: (json['attempts'] as num).toInt(),
    );

Map<String, dynamic> _$WeakCardInsightToJson(_WeakCardInsight instance) =>
    <String, dynamic>{
      'cardId': instance.cardId,
      'deckId': instance.deckId,
      'deckName': instance.deckName,
      'prompt': instance.prompt,
      'misses': instance.misses,
      'attempts': instance.attempts,
    };

_StudyDayActivity _$StudyDayActivityFromJson(Map<String, dynamic> json) =>
    _StudyDayActivity(
      day: DateTime.parse(json['day'] as String),
      reviewCount: (json['reviewCount'] as num).toInt(),
      quizAnswerCount: (json['quizAnswerCount'] as num).toInt(),
    );

Map<String, dynamic> _$StudyDayActivityToJson(_StudyDayActivity instance) =>
    <String, dynamic>{
      'day': instance.day.toIso8601String(),
      'reviewCount': instance.reviewCount,
      'quizAnswerCount': instance.quizAnswerCount,
    };

_RetentionPoint _$RetentionPointFromJson(Map<String, dynamic> json) =>
    _RetentionPoint(
      day: DateTime.parse(json['day'] as String),
      attempts: (json['attempts'] as num).toInt(),
      successes: (json['successes'] as num).toInt(),
      accuracy: (json['accuracy'] as num).toDouble(),
    );

Map<String, dynamic> _$RetentionPointToJson(_RetentionPoint instance) =>
    <String, dynamic>{
      'day': instance.day.toIso8601String(),
      'attempts': instance.attempts,
      'successes': instance.successes,
      'accuracy': instance.accuracy,
    };

_InsightsSnapshot _$InsightsSnapshotFromJson(Map<String, dynamic> json) =>
    _InsightsSnapshot(
      nextActions: (json['nextActions'] as List<dynamic>)
          .map((e) => StudyNextAction.fromJson(e as Map<String, dynamic>))
          .toList(),
      weakTags: (json['weakTags'] as List<dynamic>)
          .map((e) => WeakTagInsight.fromJson(e as Map<String, dynamic>))
          .toList(),
      weakCards: (json['weakCards'] as List<dynamic>)
          .map((e) => WeakCardInsight.fromJson(e as Map<String, dynamic>))
          .toList(),
      calendar: (json['calendar'] as List<dynamic>)
          .map((e) => StudyDayActivity.fromJson(e as Map<String, dynamic>))
          .toList(),
      retention: (json['retention'] as List<dynamic>)
          .map((e) => RetentionPoint.fromJson(e as Map<String, dynamic>))
          .toList(),
      cardsDue: (json['cardsDue'] as num).toInt(),
      streak: (json['streak'] as num).toInt(),
    );

Map<String, dynamic> _$InsightsSnapshotToJson(_InsightsSnapshot instance) =>
    <String, dynamic>{
      'nextActions': instance.nextActions.map((e) => e.toJson()).toList(),
      'weakTags': instance.weakTags.map((e) => e.toJson()).toList(),
      'weakCards': instance.weakCards.map((e) => e.toJson()).toList(),
      'calendar': instance.calendar.map((e) => e.toJson()).toList(),
      'retention': instance.retention.map((e) => e.toJson()).toList(),
      'cardsDue': instance.cardsDue,
      'streak': instance.streak,
    };
