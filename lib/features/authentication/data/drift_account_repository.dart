import 'package:drift/drift.dart';

import '../../../core/storage/database/app_database.dart';
import '../../../core/utilities/app_logger.dart';
import '../../../core/utilities/clock.dart';
import '../../../core/utilities/database_guard.dart';
import '../../../core/utilities/id_generator.dart';
import '../../sync/domain/sync_models.dart';
import '../../sync/domain/sync_outbox_repository.dart';
import '../domain/account_repository.dart';
import '../domain/account_validator.dart';
import '../domain/user_account.dart';
import 'local_account_seeder.dart';

final class DriftAccountRepository implements AccountRepository {
  DriftAccountRepository({
    required AppDatabase database,
    required IdGenerator ids,
    required Clock clock,
    required AppLogger logger,
    required SyncOutboxRepository syncOutbox,
  }) : _database = database,
       _logger = logger,
       _syncOutbox = syncOutbox,
       _seeder = LocalAccountSeeder(
         database: database,
         ids: ids,
         clock: clock,
         logger: logger,
       );

  final AppDatabase _database;
  final AppLogger _logger;
  final SyncOutboxRepository _syncOutbox;
  final LocalAccountSeeder _seeder;

  @override
  Future<UserAccount> ensureLocalAccount() => _seeder.ensureGuestAccount();

  @override
  Future<UserAccount?> findCurrent() {
    return runDatabase(
      logger: _logger,
      message: 'Your account could not be loaded.',
      action: () async {
        final row = await (_database.select(
          _database.users,
        )..limit(1)).getSingleOrNull();
        return row == null ? null : _map(row);
      },
    );
  }

  @override
  Future<UserAccount> linkEmail({
    required String email,
    required String displayName,
  }) {
    final validatedEmail = AccountValidator.email(email);
    final validatedName = AccountValidator.displayName(displayName);
    return runDatabase(
      logger: _logger,
      message: 'Your account could not be updated on this device.',
      action: () async {
        final current = await ensureLocalAccount();
        await (_database.update(
          _database.users,
        )..where((user) => user.id.equals(current.id))).write(
          UsersCompanion(
            email: Value(validatedEmail),
            displayName: Value(validatedName),
            authProvider: Value(AuthProvider.email.name),
            isGuest: const Value(false),
          ),
        );
        final updated = UserAccount(
          id: current.id,
          email: validatedEmail,
          displayName: validatedName,
          authProvider: AuthProvider.email,
          isGuest: false,
          createdAt: current.createdAt,
        );
        await _syncOutbox.enqueue(
          entityType: SyncEntityType.user,
          entityId: updated.id,
          operation: SyncOperation.upsert,
          payloadJson:
              '{"id":"${updated.id}","provider":"${updated.authProvider.name}"}',
        );
        return updated;
      },
    );
  }

  @override
  Future<UserAccount> revertToGuest() {
    return runDatabase(
      logger: _logger,
      message: 'Guest mode could not be restored on this device.',
      action: () async {
        final current = await ensureLocalAccount();
        await (_database.update(
          _database.users,
        )..where((user) => user.id.equals(current.id))).write(
          const UsersCompanion(
            email: Value(null),
            displayName: Value('Guest'),
            authProvider: Value('guest'),
            isGuest: Value(true),
          ),
        );
        final guest = UserAccount(
          id: current.id,
          displayName: 'Guest',
          authProvider: AuthProvider.guest,
          isGuest: true,
          createdAt: current.createdAt,
        );
        await _syncOutbox.enqueue(
          entityType: SyncEntityType.user,
          entityId: guest.id,
          operation: SyncOperation.upsert,
          payloadJson: '{"id":"${guest.id}","provider":"guest"}',
        );
        return guest;
      },
    );
  }

  UserAccount _map(UserRow row) {
    return UserAccount(
      id: row.id,
      email: row.email,
      displayName: row.displayName,
      authProvider: AuthProvider.values.byName(row.authProvider),
      isGuest: row.isGuest,
      createdAt: row.createdAt.toUtc(),
    );
  }
}
