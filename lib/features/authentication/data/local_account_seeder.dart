import '../../../core/storage/database/app_database.dart';
import '../../../core/utilities/clock.dart';
import '../../../core/utilities/database_guard.dart';
import '../../../core/utilities/app_logger.dart';
import '../../../core/utilities/id_generator.dart';
import '../domain/user_account.dart';

/// Creates the on-device guest account used until authentication exists.
///
/// The app does not block on sign-in. Cloud accounts can later link this row.
final class LocalAccountSeeder {
  const LocalAccountSeeder({
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

  Future<UserAccount> ensureGuestAccount() {
    return runDatabase(
      logger: _logger,
      message: 'Flashhh could not open your account on this device.',
      action: () async {
        final existing = await (_database.select(
          _database.users,
        )..limit(1)).getSingleOrNull();
        if (existing != null) {
          return _map(existing);
        }
        final now = _clock.now();
        final id = _ids.next();
        await _database
            .into(_database.users)
            .insert(
              UsersCompanion.insert(
                id: id,
                displayName: 'Guest',
                authProvider: AuthProvider.guest.name,
                isGuest: true,
                createdAt: now,
              ),
            );
        return UserAccount(
          id: id,
          displayName: 'Guest',
          authProvider: AuthProvider.guest,
          isGuest: true,
          createdAt: now,
        );
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
