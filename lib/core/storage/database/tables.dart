import 'package:drift/drift.dart';

/// Local-first schema.
///
/// Scheduling columns match the fields a spaced-repetition scheduler needs
/// (SM-2 ease, interval, repetitions, and lapses, plus the review counters
/// the product tracks). New cards leave [nextReviewAt] empty, which the
/// dashboard treats as due. No scheduler writes these fields yet.
const int initialEaseFactorMillis = 2500;

@DataClassName('UserRow')
class Users extends Table {
  TextColumn get id => text()();

  TextColumn get email => text().nullable()();

  TextColumn get displayName => text()();

  TextColumn get authProvider => text()();

  BoolColumn get isGuest => boolean()();

  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('DeckRow')
@TableIndex(name: 'decks_owner_idx', columns: {#ownerId})
class Decks extends Table {
  TextColumn get id => text()();

  TextColumn get ownerId => text().references(Users, #id)();

  TextColumn get name => text()();

  TextColumn get description => text().withDefault(const Constant(''))();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get updatedAt => dateTime()();

  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('FlashcardRow')
@TableIndex(name: 'flashcards_deck_idx', columns: {#deckId})
@TableIndex(name: 'flashcards_next_review_idx', columns: {#nextReviewAt})
class Flashcards extends Table {
  TextColumn get id => text()();

  TextColumn get deckId => text().references(Decks, #id)();

  TextColumn get question => text()();

  TextColumn get answer => text()();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get updatedAt => dateTime()();

  TextColumn get source => text()();

  TextColumn get difficulty => text().nullable()();

  /// `basic`, `cloze`, or `reverse`. Stored as the Dart enum `.name`.
  TextColumn get cardType => text().withDefault(const Constant('basic'))();

  DateTimeColumn get deletedAt => dateTime().nullable()();

  DateTimeColumn get lastReviewedAt => dateTime().nullable()();

  DateTimeColumn get nextReviewAt => dateTime().nullable()();

  IntColumn get reviewCount => integer().withDefault(const Constant(0))();

  IntColumn get successCount => integer().withDefault(const Constant(0))();

  IntColumn get failureCount => integer().withDefault(const Constant(0))();

  /// SM-2 ease factor stored as thousandths (2500 means 2.5).
  IntColumn get easeFactorMillis =>
      integer().withDefault(const Constant(initialEaseFactorMillis))();

  IntColumn get intervalDays => integer().withDefault(const Constant(0))();

  IntColumn get repetitions => integer().withDefault(const Constant(0))();

  IntColumn get lapses => integer().withDefault(const Constant(0))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('FlashcardTagRow')
class FlashcardTags extends Table {
  TextColumn get cardId => text().references(Flashcards, #id)();

  TextColumn get tag => text()();

  @override
  Set<Column<Object>> get primaryKey => {cardId, tag};
}

@DataClassName('StudySessionRow')
class StudySessions extends Table {
  TextColumn get id => text()();

  TextColumn get deckId => text().nullable().references(Decks, #id)();

  DateTimeColumn get startedAt => dateTime()();

  DateTimeColumn get completedAt => dateTime().nullable()();

  IntColumn get cardsReviewed => integer().withDefault(const Constant(0))();

  IntColumn get againCount => integer().withDefault(const Constant(0))();

  IntColumn get hardCount => integer().withDefault(const Constant(0))();

  IntColumn get goodCount => integer().withDefault(const Constant(0))();

  IntColumn get easyCount => integer().withDefault(const Constant(0))();

  /// `review` (SM-2) or `cram` (ignore schedule). Stored as `.name`.
  TextColumn get mode => text().withDefault(const Constant('review'))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('ReviewResultRow')
@TableIndex(name: 'review_results_reviewed_at_idx', columns: {#reviewedAt})
@TableIndex(name: 'review_results_card_idx', columns: {#cardId})
class ReviewResults extends Table {
  TextColumn get id => text()();

  TextColumn get sessionId => text().references(StudySessions, #id)();

  TextColumn get cardId => text().references(Flashcards, #id)();

  TextColumn get grade => text()();

  DateTimeColumn get reviewedAt => dateTime()();

  IntColumn get previousIntervalDays => integer().nullable()();

  IntColumn get newIntervalDays => integer().nullable()();

  IntColumn get elapsedMilliseconds => integer().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('DocumentImportRow')
class DocumentImports extends Table {
  TextColumn get id => text()();

  TextColumn get fileName => text()();

  IntColumn get byteSize => integer()();

  TextColumn get contentHash => text().nullable()();

  IntColumn get pageCount => integer().nullable()();

  IntColumn get textCharacterCount => integer().nullable()();

  TextColumn get status => text()();

  TextColumn get errorMessage => text().nullable()();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get updatedAt => dateTime()();

  DateTimeColumn get discardedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('GenerationUsageRow')
class GenerationUsageRecords extends Table {
  TextColumn get id => text()();

  TextColumn get documentImportId =>
      text().nullable().references(DocumentImports, #id)();

  DateTimeColumn get createdAt => dateTime()();

  TextColumn get status => text()();

  IntColumn get documentBytes => integer().nullable()();

  IntColumn get promptTokens => integer().nullable()();

  IntColumn get completionTokens => integer().nullable()();

  IntColumn get cardCount => integer().nullable()();

  RealColumn get estimatedCostUsd => real().nullable()();

  TextColumn get failureCode => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('AppPreferenceRow')
class AppPreferences extends Table {
  IntColumn get id => integer()();

  TextColumn get themeMode => text().withDefault(const Constant('system'))();

  BoolColumn get hasCompletedOnboarding =>
      boolean().withDefault(const Constant(false))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Pending local changes waiting for a future cloud sync endpoint.
@DataClassName('SyncOutboxRow')
@TableIndex(name: 'sync_outbox_created_at_idx', columns: {#createdAt})
@TableIndex(name: 'sync_outbox_entity_idx', columns: {#entityType, #entityId})
class SyncOutboxEntries extends Table {
  TextColumn get id => text()();

  TextColumn get entityType => text()();

  TextColumn get entityId => text()();

  TextColumn get operation => text()();

  TextColumn get payloadJson => text().nullable()();

  DateTimeColumn get createdAt => dateTime()();

  IntColumn get attemptCount => integer().withDefault(const Constant(0))();

  TextColumn get lastError => text().nullable()();

  DateTimeColumn get processedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('QuizAttemptRow')
@TableIndex(name: 'quiz_attempts_started_at_idx', columns: {#startedAt})
@TableIndex(name: 'quiz_attempts_deck_idx', columns: {#deckId})
class QuizAttempts extends Table {
  TextColumn get id => text()();

  TextColumn get deckId => text().nullable().references(Decks, #id)();

  TextColumn get questionStyle => text()();

  IntColumn get timedSeconds => integer().nullable()();

  IntColumn get questionCount => integer().withDefault(const Constant(0))();

  IntColumn get correctCount => integer().withDefault(const Constant(0))();

  DateTimeColumn get startedAt => dateTime()();

  DateTimeColumn get completedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('QuizAnswerRow')
@TableIndex(name: 'quiz_answers_attempt_idx', columns: {#attemptId})
class QuizAnswers extends Table {
  TextColumn get id => text()();

  TextColumn get attemptId => text().references(QuizAttempts, #id)();

  TextColumn get cardId => text().references(Flashcards, #id)();

  TextColumn get questionType => text()();

  TextColumn get prompt => text()();

  TextColumn get correctAnswer => text()();

  TextColumn get givenAnswer => text().nullable()();

  TextColumn get choicesJson => text().nullable()();

  BoolColumn get isCorrect => boolean()();

  DateTimeColumn get answeredAt => dateTime()();

  IntColumn get elapsedMilliseconds => integer().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
