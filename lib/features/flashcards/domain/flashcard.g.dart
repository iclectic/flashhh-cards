// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flashcard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Flashcard _$FlashcardFromJson(Map<String, dynamic> json) => _Flashcard(
  id: json['id'] as String,
  deckId: json['deckId'] as String,
  question: json['question'] as String,
  answer: json['answer'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  source: $enumDecode(_$FlashcardSourceEnumMap, json['source']),
  difficulty: $enumDecodeNullable(_$DifficultyEnumMap, json['difficulty']),
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  lastReviewedAt: json['lastReviewedAt'] == null
      ? null
      : DateTime.parse(json['lastReviewedAt'] as String),
  nextReviewAt: json['nextReviewAt'] == null
      ? null
      : DateTime.parse(json['nextReviewAt'] as String),
  reviewCount: (json['reviewCount'] as num?)?.toInt() ?? 0,
  successCount: (json['successCount'] as num?)?.toInt() ?? 0,
  failureCount: (json['failureCount'] as num?)?.toInt() ?? 0,
  easeFactor: (json['easeFactor'] as num?)?.toDouble() ?? 2.5,
  intervalDays: (json['intervalDays'] as num?)?.toInt() ?? 0,
  repetitions: (json['repetitions'] as num?)?.toInt() ?? 0,
  lapses: (json['lapses'] as num?)?.toInt() ?? 0,
  deletedAt: json['deletedAt'] == null
      ? null
      : DateTime.parse(json['deletedAt'] as String),
);

Map<String, dynamic> _$FlashcardToJson(_Flashcard instance) =>
    <String, dynamic>{
      'id': instance.id,
      'deckId': instance.deckId,
      'question': instance.question,
      'answer': instance.answer,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'source': _$FlashcardSourceEnumMap[instance.source]!,
      'difficulty': _$DifficultyEnumMap[instance.difficulty],
      'tags': instance.tags,
      'lastReviewedAt': instance.lastReviewedAt?.toIso8601String(),
      'nextReviewAt': instance.nextReviewAt?.toIso8601String(),
      'reviewCount': instance.reviewCount,
      'successCount': instance.successCount,
      'failureCount': instance.failureCount,
      'easeFactor': instance.easeFactor,
      'intervalDays': instance.intervalDays,
      'repetitions': instance.repetitions,
      'lapses': instance.lapses,
      'deletedAt': instance.deletedAt?.toIso8601String(),
    };

const _$FlashcardSourceEnumMap = {
  FlashcardSource.manual: 'manual',
  FlashcardSource.pdf: 'pdf',
  FlashcardSource.aiGenerated: 'ai_generated',
};

const _$DifficultyEnumMap = {
  Difficulty.easy: 'easy',
  Difficulty.medium: 'medium',
  Difficulty.hard: 'hard',
};
