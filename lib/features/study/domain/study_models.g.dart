// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StudySession _$StudySessionFromJson(Map<String, dynamic> json) =>
    _StudySession(
      id: json['id'] as String,
      deckId: json['deckId'] as String?,
      startedAt: DateTime.parse(json['startedAt'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      cardsReviewed: (json['cardsReviewed'] as num?)?.toInt() ?? 0,
      againCount: (json['againCount'] as num?)?.toInt() ?? 0,
      hardCount: (json['hardCount'] as num?)?.toInt() ?? 0,
      goodCount: (json['goodCount'] as num?)?.toInt() ?? 0,
      easyCount: (json['easyCount'] as num?)?.toInt() ?? 0,
      mode:
          $enumDecodeNullable(_$StudySessionModeEnumMap, json['mode']) ??
          StudySessionMode.review,
    );

Map<String, dynamic> _$StudySessionToJson(_StudySession instance) =>
    <String, dynamic>{
      'id': instance.id,
      'deckId': instance.deckId,
      'startedAt': instance.startedAt.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
      'cardsReviewed': instance.cardsReviewed,
      'againCount': instance.againCount,
      'hardCount': instance.hardCount,
      'goodCount': instance.goodCount,
      'easyCount': instance.easyCount,
      'mode': _$StudySessionModeEnumMap[instance.mode]!,
    };

const _$StudySessionModeEnumMap = {
  StudySessionMode.review: 'review',
  StudySessionMode.cram: 'cram',
};

_ReviewResult _$ReviewResultFromJson(Map<String, dynamic> json) =>
    _ReviewResult(
      id: json['id'] as String,
      sessionId: json['sessionId'] as String,
      cardId: json['cardId'] as String,
      grade: $enumDecode(_$RecallGradeEnumMap, json['grade']),
      reviewedAt: DateTime.parse(json['reviewedAt'] as String),
      previousIntervalDays: (json['previousIntervalDays'] as num?)?.toInt(),
      newIntervalDays: (json['newIntervalDays'] as num?)?.toInt(),
      elapsedMilliseconds: (json['elapsedMilliseconds'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ReviewResultToJson(_ReviewResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sessionId': instance.sessionId,
      'cardId': instance.cardId,
      'grade': _$RecallGradeEnumMap[instance.grade]!,
      'reviewedAt': instance.reviewedAt.toIso8601String(),
      'previousIntervalDays': instance.previousIntervalDays,
      'newIntervalDays': instance.newIntervalDays,
      'elapsedMilliseconds': instance.elapsedMilliseconds,
    };

const _$RecallGradeEnumMap = {
  RecallGrade.again: 'again',
  RecallGrade.hard: 'hard',
  RecallGrade.good: 'good',
  RecallGrade.easy: 'easy',
};

_DeckProgress _$DeckProgressFromJson(Map<String, dynamic> json) =>
    _DeckProgress(
      deckId: json['deckId'] as String,
      deckName: json['deckName'] as String,
      totalCards: (json['totalCards'] as num).toInt(),
      reviewedCards: (json['reviewedCards'] as num).toInt(),
    );

Map<String, dynamic> _$DeckProgressToJson(_DeckProgress instance) =>
    <String, dynamic>{
      'deckId': instance.deckId,
      'deckName': instance.deckName,
      'totalCards': instance.totalCards,
      'reviewedCards': instance.reviewedCards,
    };

_DashboardSnapshot _$DashboardSnapshotFromJson(Map<String, dynamic> json) =>
    _DashboardSnapshot(
      cardsDue: (json['cardsDue'] as num).toInt(),
      cardsStudiedToday: (json['cardsStudiedToday'] as num).toInt(),
      streak: (json['streak'] as num).toInt(),
      decks: (json['decks'] as List<dynamic>)
          .map((e) => DeckProgress.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DashboardSnapshotToJson(_DashboardSnapshot instance) =>
    <String, dynamic>{
      'cardsDue': instance.cardsDue,
      'cardsStudiedToday': instance.cardsStudiedToday,
      'streak': instance.streak,
      'decks': instance.decks.map((e) => e.toJson()).toList(),
    };
