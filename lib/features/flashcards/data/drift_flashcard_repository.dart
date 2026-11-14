import 'package:drift/drift.dart';

import '../../../core/analytics/analytics_client.dart';
import '../../../core/analytics/analytics_event.dart';
import '../../../core/errors/app_exception.dart';
import '../../../core/storage/database/app_database.dart';
import '../../../core/utilities/app_logger.dart';
import '../../../core/utilities/clock.dart';
import '../../../core/utilities/database_guard.dart';
import '../../../core/utilities/id_generator.dart';
import '../../../core/validation/text_rules.dart';
import '../../sync/domain/sync_models.dart';
import '../../sync/domain/sync_outbox_repository.dart';
import '../domain/flashcard.dart';
import '../domain/flashcard_repository.dart';
import '../domain/flashcard_validator.dart';

final class DriftFlashcardRepository implements FlashcardRepository {
  DriftFlashcardRepository({
    required AppDatabase database,
    required IdGenerator ids,
    required Clock clock,
    required AppLogger logger,
    SyncOutboxRepository? syncOutbox,
    AnalyticsClient? analytics,
  }) : _database = database,
       _ids = ids,
       _clock = clock,
       _logger = logger,
       _syncOutbox = syncOutbox,
       _analytics = analytics;

  final AppDatabase _database;
  final IdGenerator _ids;
  final Clock _clock;
  final AppLogger _logger;
  final SyncOutboxRepository? _syncOutbox;
  final AnalyticsClient? _analytics;

  @override
  Future<List<Flashcard>> search(FlashcardQuery query) {
    FlashcardValidator.page(limit: query.limit, offset: query.offset);
    return runDatabase(
      logger: _logger,
      message: 'Flashcards could not be loaded.',
      action: () async {
        final stmt = _database.select(_database.flashcards)
          ..where((card) => card.deletedAt.isNull());
        final deckId = query.deckId;
        if (deckId != null) {
          stmt.where((card) => card.deckId.equals(deckId));
        }
        final difficulty = query.difficulty;
        if (difficulty != null) {
          stmt.where((card) => card.difficulty.equals(difficulty.name));
        }
        final source = query.source;
        if (source != null) {
          stmt.where((card) => card.source.equals(source.name));
        }
        final tag = query.tag == null ? '' : normalizeTag(query.tag!);
        if (tag.isNotEmpty) {
          final matching = _database.selectOnly(_database.flashcardTags)
            ..addColumns([_database.flashcardTags.cardId])
            ..where(_database.flashcardTags.tag.equals(tag));
          stmt.where((card) => card.id.isInQuery(matching));
        }
        final text = query.text?.trim();
        if (text != null && text.isNotEmpty) {
          final pattern = '%${escapeLike(text.toLowerCase())}%';
          final tagged = _database.selectOnly(_database.flashcardTags)
            ..addColumns([_database.flashcardTags.cardId])
            ..where(
              _database.flashcardTags.tag.lower().like(
                pattern,
                escapeChar: r'\',
              ),
            );
          stmt.where(
            (card) =>
                card.question.lower().like(pattern, escapeChar: r'\') |
                card.answer.lower().like(pattern, escapeChar: r'\') |
                card.id.isInQuery(tagged),
          );
        }
        stmt
          ..orderBy([
            (card) => OrderingTerm(
              expression: card.updatedAt,
              mode: OrderingMode.desc,
            ),
          ])
          ..limit(query.limit, offset: query.offset);
        final rows = await stmt.get();
        return _withTags(rows);
      },
    );
  }

  @override
  Future<Flashcard?> findById(String id) {
    return runDatabase(
      logger: _logger,
      message: 'That flashcard could not be loaded.',
      action: () async {
        final row = await _livingRow(id);
        if (row == null) {
          return null;
        }
        final cards = await _withTags([row]);
        return cards.single;
      },
    );
  }

  @override
  Future<Flashcard> create(NewFlashcard draft) async {
    final content = FlashcardValidator.content(
      question: draft.question,
      answer: draft.answer,
      tags: draft.tags,
      cardType: draft.cardType,
    );
    final created = await runDatabase(
      logger: _logger,
      message: 'The flashcard could not be saved on this device.',
      action: () async {
        await _requireDeck(draft.deckId);
        final now = _clock.now();
        final id = _ids.next();
        await _database.transaction(() async {
          await _database
              .into(_database.flashcards)
              .insert(
                FlashcardsCompanion.insert(
                  id: id,
                  deckId: draft.deckId,
                  question: content.question,
                  answer: content.answer,
                  createdAt: now,
                  updatedAt: now,
                  source: draft.source.name,
                  difficulty: Value(draft.difficulty?.name),
                  cardType: Value(content.cardType.name),
                ),
              );
          await _replaceTags(id, content.tags);
        });
        final row = await _livingRow(id);
        if (row == null) {
          throw const DatabaseException(
            message: 'The flashcard could not be saved on this device.',
          );
        }
        return (await _withTags([row])).single;
      },
    );
    await _enqueue(SyncOperation.upsert, created.id);
    return created;
  }

  @override
  Future<Flashcard> update(FlashcardUpdate update) async {
    final content = FlashcardValidator.content(
      question: update.question,
      answer: update.answer,
      tags: update.tags,
      cardType: update.cardType,
    );
    final card = await runDatabase(
      logger: _logger,
      message: 'The flashcard could not be saved on this device.',
      action: () async {
        final existing = await _livingRow(update.id);
        if (existing == null) {
          throw const ValidationException(
            message: 'That flashcard no longer exists.',
          );
        }
        await _database.transaction(() async {
          await (_database.update(
            _database.flashcards,
          )..where((card) => card.id.equals(update.id))).write(
            FlashcardsCompanion(
              question: Value(content.question),
              answer: Value(content.answer),
              difficulty: Value(update.difficulty?.name),
              cardType: Value(content.cardType.name),
              updatedAt: Value(_clock.now()),
            ),
          );
          await _replaceTags(update.id, content.tags);
        });
        final row = await _livingRow(update.id);
        if (row == null) {
          throw const ValidationException(
            message: 'That flashcard no longer exists.',
          );
        }
        return (await _withTags([row])).single;
      },
    );
    await _enqueue(SyncOperation.upsert, card.id);
    return card;
  }

  @override
  Future<void> delete(String id) async {
    await runDatabase(
      logger: _logger,
      message: 'The flashcard could not be deleted on this device.',
      action: () async {
        final now = _clock.now();
        await (_database.update(
          _database.flashcards,
        )..where((card) => card.id.equals(id) & card.deletedAt.isNull())).write(
          FlashcardsCompanion(deletedAt: Value(now), updatedAt: Value(now)),
        );
      },
    );
    await _enqueue(SyncOperation.delete, id);
  }

  Future<void> _enqueue(SyncOperation operation, String entityId) async {
    final outbox = _syncOutbox;
    if (outbox == null) {
      return;
    }
    await outbox.enqueue(
      entityType: SyncEntityType.flashcard,
      entityId: entityId,
      operation: operation,
      payloadJson: '{"id":"$entityId"}',
    );
    await _analytics?.track(
      AnalyticsEvent.syncChangeEnqueued,
      properties: {
        'entity': SyncEntityType.flashcard.name,
        'operation': operation.name,
      },
    );
  }

  @override
  Future<Flashcard> move({
    required String id,
    required String destinationDeckId,
  }) {
    return runDatabase(
      logger: _logger,
      message: 'The flashcard could not be moved.',
      action: () async {
        final existing = await _livingRow(id);
        if (existing == null) {
          throw const ValidationException(
            message: 'That flashcard no longer exists.',
          );
        }
        if (existing.deckId != destinationDeckId) {
          await _requireDeck(destinationDeckId);
          await (_database.update(
            _database.flashcards,
          )..where((card) => card.id.equals(id))).write(
            FlashcardsCompanion(
              deckId: Value(destinationDeckId),
              updatedAt: Value(_clock.now()),
            ),
          );
        }
        final row = await _livingRow(id);
        if (row == null) {
          throw const ValidationException(
            message: 'That flashcard no longer exists.',
          );
        }
        return (await _withTags([row])).single;
      },
    );
  }

  @override
  Future<Flashcard> duplicate(String id) {
    return runDatabase(
      logger: _logger,
      message: 'The flashcard could not be duplicated.',
      action: () async {
        final existing = await _livingRow(id);
        if (existing == null) {
          throw const ValidationException(
            message: 'That flashcard no longer exists.',
          );
        }
        final tags = (await _tagsFor([existing.id]))[existing.id] ?? const [];
        final now = _clock.now();
        final newId = _ids.next();
        await _database.transaction(() async {
          await _database
              .into(_database.flashcards)
              .insert(
                FlashcardsCompanion.insert(
                  id: newId,
                  deckId: existing.deckId,
                  question: existing.question,
                  answer: existing.answer,
                  createdAt: now,
                  updatedAt: now,
                  source: existing.source,
                  difficulty: Value(existing.difficulty),
                  cardType: Value(existing.cardType),
                ),
              );
          await _replaceTags(newId, tags);
        });
        final row = await _livingRow(newId);
        if (row == null) {
          throw const DatabaseException(
            message: 'The flashcard could not be duplicated.',
          );
        }
        return (await _withTags([row])).single;
      },
    );
  }

  Future<FlashcardRow?> _livingRow(String id) {
    return (_database.select(_database.flashcards)
          ..where((card) => card.id.equals(id) & card.deletedAt.isNull()))
        .getSingleOrNull();
  }

  Future<void> _requireDeck(String id) async {
    final deck =
        await (_database.select(_database.decks)
              ..where((row) => row.id.equals(id) & row.deletedAt.isNull()))
            .getSingleOrNull();
    if (deck == null) {
      throw const ValidationException(message: 'That deck no longer exists.');
    }
  }

  Future<void> _replaceTags(String cardId, List<String> tags) async {
    await (_database.delete(
      _database.flashcardTags,
    )..where((row) => row.cardId.equals(cardId))).go();
    if (tags.isEmpty) {
      return;
    }
    await _database.batch((batch) {
      batch.insertAll(_database.flashcardTags, [
        for (final tag in tags)
          FlashcardTagsCompanion.insert(cardId: cardId, tag: tag),
      ]);
    });
  }

  Future<List<Flashcard>> _withTags(List<FlashcardRow> rows) async {
    final tags = await _tagsFor(rows.map((row) => row.id).toList());
    return [for (final row in rows) _map(row, tags[row.id] ?? const [])];
  }

  Future<Map<String, List<String>>> _tagsFor(List<String> ids) async {
    if (ids.isEmpty) {
      return const {};
    }
    final rows = await (_database.select(
      _database.flashcardTags,
    )..where((row) => row.cardId.isIn(ids))).get();
    final grouped = <String, List<String>>{};
    for (final row in rows) {
      grouped.putIfAbsent(row.cardId, () => []).add(row.tag);
    }
    for (final tags in grouped.values) {
      tags.sort();
    }
    return grouped;
  }

  Flashcard _map(FlashcardRow row, List<String> tags) {
    return Flashcard(
      id: row.id,
      deckId: row.deckId,
      question: row.question,
      answer: row.answer,
      createdAt: row.createdAt.toUtc(),
      updatedAt: row.updatedAt.toUtc(),
      source: FlashcardSource.values.byName(row.source),
      difficulty: row.difficulty == null
          ? null
          : Difficulty.values.byName(row.difficulty!),
      cardType: FlashcardCardType.values.byName(row.cardType),
      tags: tags,
      lastReviewedAt: row.lastReviewedAt?.toUtc(),
      nextReviewAt: row.nextReviewAt?.toUtc(),
      reviewCount: row.reviewCount,
      successCount: row.successCount,
      failureCount: row.failureCount,
      easeFactor: row.easeFactorMillis / 1000,
      intervalDays: row.intervalDays,
      repetitions: row.repetitions,
      lapses: row.lapses,
      deletedAt: row.deletedAt?.toUtc(),
    );
  }
}
