import 'package:drift/drift.dart';

import '../../../core/errors/app_exception.dart';
import '../../../core/storage/database/app_database.dart';
import '../../../core/utilities/app_logger.dart';
import '../../../core/utilities/clock.dart';
import '../../../core/utilities/database_guard.dart';
import '../../../core/utilities/id_generator.dart';
import '../domain/deck.dart';
import '../domain/deck_repository.dart';
import '../domain/deck_validator.dart';

final class DriftDeckRepository implements DeckRepository {
  DriftDeckRepository({
    required AppDatabase database,
    required IdGenerator ids,
    required Clock clock,
    required AppLogger logger,
  }) : _database = database,
       _ids = ids,
       _clock = clock,
       _logger = logger;

  final AppDatabase _database;
  final IdGenerator _ids;
  final Clock _clock;
  final AppLogger _logger;

  @override
  Future<List<Deck>> listDecks({required String ownerId}) {
    return runDatabase(
      logger: _logger,
      message: 'Your decks could not be loaded.',
      action: () async {
        final rows =
            await (_database.select(_database.decks)..where(
                  (deck) =>
                      deck.ownerId.equals(ownerId) & deck.deletedAt.isNull(),
                ))
                .get();
        final counts = await _cardCounts(rows.map((row) => row.id).toList());
        final decks = [
          for (final row in rows) _map(row, counts[row.id] ?? 0),
        ]..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
        return decks;
      },
    );
  }

  @override
  Future<Deck?> findById(String id) {
    return runDatabase(
      logger: _logger,
      message: 'That deck could not be loaded.',
      action: () async {
        final row =
            await (_database.select(_database.decks)..where(
                  (deck) => deck.id.equals(id) & deck.deletedAt.isNull(),
                ))
                .getSingleOrNull();
        if (row == null) {
          return null;
        }
        final counts = await _cardCounts([row.id]);
        return _map(row, counts[row.id] ?? 0);
      },
    );
  }

  @override
  Future<Deck> createDeck({
    required String ownerId,
    required String name,
    required String description,
  }) {
    final validatedName = DeckValidator.name(name);
    final validatedDescription = DeckValidator.description(description);
    return runDatabase(
      logger: _logger,
      message: 'The deck could not be saved on this device.',
      action: () async {
        final now = _clock.now();
        final id = _ids.next();
        await _database
            .into(_database.decks)
            .insert(
              DecksCompanion.insert(
                id: id,
                ownerId: ownerId,
                name: validatedName,
                description: Value(validatedDescription),
                createdAt: now,
                updatedAt: now,
              ),
            );
        final created = await findById(id);
        if (created == null) {
          throw const DatabaseException(
            message: 'The deck could not be saved on this device.',
          );
        }
        return created;
      },
    );
  }

  @override
  Future<Deck> updateDeck({
    required String id,
    required String name,
    required String description,
  }) {
    final validatedName = DeckValidator.name(name);
    final validatedDescription = DeckValidator.description(description);
    return runDatabase(
      logger: _logger,
      message: 'The deck could not be saved on this device.',
      action: () async {
        final updated =
            await (_database.update(_database.decks)..where(
                  (deck) => deck.id.equals(id) & deck.deletedAt.isNull(),
                ))
                .write(
                  DecksCompanion(
                    name: Value(validatedName),
                    description: Value(validatedDescription),
                    updatedAt: Value(_clock.now()),
                  ),
                );
        if (updated == 0) {
          throw const ValidationException(
            message: 'That deck no longer exists.',
          );
        }
        final deck = await findById(id);
        if (deck == null) {
          throw const ValidationException(
            message: 'That deck no longer exists.',
          );
        }
        return deck;
      },
    );
  }

  @override
  Future<void> deleteDeck(String id) {
    return runDatabase(
      logger: _logger,
      message: 'The deck could not be deleted on this device.',
      action: () async {
        final now = _clock.now();
        await _database.transaction(() async {
          final updated =
              await (_database.update(_database.decks)..where(
                    (deck) => deck.id.equals(id) & deck.deletedAt.isNull(),
                  ))
                  .write(
                    DecksCompanion(
                      deletedAt: Value(now),
                      updatedAt: Value(now),
                    ),
                  );
          if (updated == 0) {
            return;
          }
          await (_database.update(_database.flashcards)..where(
                (card) => card.deckId.equals(id) & card.deletedAt.isNull(),
              ))
              .write(
                FlashcardsCompanion(
                  deletedAt: Value(now),
                  updatedAt: Value(now),
                ),
              );
        });
      },
    );
  }

  Future<Map<String, int>> _cardCounts(List<String> deckIds) async {
    if (deckIds.isEmpty) {
      return const {};
    }
    final count = _database.flashcards.id.count();
    final rows =
        await (_database.selectOnly(_database.flashcards)
              ..addColumns([_database.flashcards.deckId, count])
              ..where(
                _database.flashcards.deletedAt.isNull() &
                    _database.flashcards.deckId.isIn(deckIds),
              )
              ..groupBy([_database.flashcards.deckId]))
            .get();
    return {
      for (final row in rows)
        row.read(_database.flashcards.deckId)!: row.read(count)!,
    };
  }

  Deck _map(DeckRow row, int cardCount) {
    return Deck(
      id: row.id,
      ownerId: row.ownerId,
      name: row.name,
      description: row.description,
      createdAt: row.createdAt.toUtc(),
      updatedAt: row.updatedAt.toUtc(),
      deletedAt: row.deletedAt?.toUtc(),
      cardCount: cardCount,
    );
  }
}
