import 'package:freezed_annotation/freezed_annotation.dart';

part 'flashcard.freezed.dart';
part 'flashcard.g.dart';

@JsonEnum(fieldRename: FieldRename.snake)
enum FlashcardSource { manual, pdf, aiGenerated }

enum Difficulty { easy, medium, hard }

/// How the card is studied. Stored as `.name` in SQLite.
enum FlashcardCardType { basic, cloze, reverse }

@freezed
abstract class Flashcard with _$Flashcard {
  const factory Flashcard({
    required String id,
    required String deckId,
    required String question,
    required String answer,
    required DateTime createdAt,
    required DateTime updatedAt,
    required FlashcardSource source,
    Difficulty? difficulty,
    @Default(FlashcardCardType.basic) FlashcardCardType cardType,
    @Default(<String>[]) List<String> tags,
    DateTime? lastReviewedAt,
    DateTime? nextReviewAt,
    @Default(0) int reviewCount,
    @Default(0) int successCount,
    @Default(0) int failureCount,
    @Default(2.5) double easeFactor,
    @Default(0) int intervalDays,
    @Default(0) int repetitions,
    @Default(0) int lapses,
    DateTime? deletedAt,
  }) = _Flashcard;

  factory Flashcard.fromJson(Map<String, dynamic> json) =>
      _$FlashcardFromJson(json);
}

/// Full content replacement used by the card editor.
final class NewFlashcard {
  const NewFlashcard({
    required this.deckId,
    required this.question,
    required this.answer,
    this.difficulty,
    this.tags = const [],
    this.source = FlashcardSource.manual,
    this.cardType = FlashcardCardType.basic,
  });

  final String deckId;
  final String question;
  final String answer;
  final Difficulty? difficulty;
  final List<String> tags;
  final FlashcardSource source;
  final FlashcardCardType cardType;
}

final class FlashcardUpdate {
  const FlashcardUpdate({
    required this.id,
    required this.question,
    required this.answer,
    this.difficulty,
    this.tags = const [],
    this.cardType = FlashcardCardType.basic,
  });

  final String id;
  final String question;
  final String answer;
  final Difficulty? difficulty;
  final List<String> tags;
  final FlashcardCardType cardType;
}

final class FlashcardQuery {
  const FlashcardQuery({
    this.deckId,
    this.text,
    this.difficulty,
    this.source,
    this.tag,
    this.limit = 50,
    this.offset = 0,
  });

  final String? deckId;
  final String? text;
  final Difficulty? difficulty;
  final FlashcardSource? source;
  final String? tag;
  final int limit;
  final int offset;
}
