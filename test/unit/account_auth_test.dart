import 'package:drift/native.dart';
import 'package:flashhh_cards/core/analytics/analytics_client.dart';
import 'package:flashhh_cards/core/errors/app_exception.dart';
import 'package:flashhh_cards/core/storage/database/app_database.dart';
import 'package:flashhh_cards/features/authentication/data/drift_account_repository.dart';
import 'package:flashhh_cards/features/authentication/data/local_auth_service.dart';
import 'package:flashhh_cards/features/authentication/data/secure_auth_session_store.dart';
import 'package:flashhh_cards/features/authentication/domain/account_validator.dart';
import 'package:flashhh_cards/features/authentication/domain/user_account.dart';
import 'package:flashhh_cards/features/sync/data/drift_sync_outbox_repository.dart';
import 'package:flashhh_cards/features/sync/domain/sync_models.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/fakes.dart';

void main() {
  late AppDatabase database;
  late FakeClock clock;
  late SequentialIdGenerator ids;
  late RecordingLogger logger;
  late MemorySecureStore secureStore;
  late DriftSyncOutboxRepository outbox;
  late DriftAccountRepository accounts;
  late LocalAuthService auth;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    clock = FakeClock(DateTime.utc(2026, 6, 15, 12));
    ids = SequentialIdGenerator();
    logger = RecordingLogger();
    secureStore = MemorySecureStore();
    outbox = DriftSyncOutboxRepository(
      database: database,
      ids: ids,
      clock: clock,
      logger: logger,
    );
    accounts = DriftAccountRepository(
      database: database,
      ids: ids,
      clock: clock,
      logger: logger,
      syncOutbox: outbox,
    );
    auth = LocalAuthService(
      accounts: accounts,
      sessions: SecureAuthSessionStore(
        secureStore: secureStore,
        logger: logger,
      ),
      ids: ids,
      clock: clock,
      analytics: const NoOpAnalyticsClient(),
    );
  });

  tearDown(() => database.close());

  test('email validator accepts and normalizes addresses', () {
    expect(AccountValidator.email('  Alex@Example.COM '), 'alex@example.com');
    expect(
      () => AccountValidator.email('not-an-email'),
      throwsA(isA<ValidationException>()),
    );
  });

  test('links email on the same guest id and stores a session', () async {
    final guest = await accounts.ensureLocalAccount();
    expect(guest.isGuest, isTrue);

    final linked = await auth.linkEmail(
      email: 'learner@flashhh.app',
      displayName: 'Learner',
    );

    expect(linked.account.id, guest.id);
    expect(linked.account.isGuest, isFalse);
    expect(linked.account.email, 'learner@flashhh.app');
    expect(linked.account.authProvider, AuthProvider.email);
    expect(linked.session.provider, AuthProvider.email);

    final session = await auth.readSession();
    expect(session?.accessToken, linked.session.accessToken);

    final pending = await outbox.listPending();
    expect(pending, isNotEmpty);
    expect(pending.first.entityType, SyncEntityType.user);
    expect(pending.first.operation, SyncOperation.upsert);
  });

  test('sign out restores guest mode and clears tokens', () async {
    await auth.linkEmail(email: 'a@b.co', displayName: 'A');
    final guest = await auth.signOutToGuest();

    expect(guest.isGuest, isTrue);
    expect(guest.email, isNull);
    expect(await auth.readSession(), isNull);
    expect(secureStore.values, isEmpty);
  });

  test('google and apple are honest failures', () async {
    expect(
      () => auth.signInWithGoogle(),
      throwsA(isA<AuthenticationException>()),
    );
    expect(
      () => auth.signInWithApple(),
      throwsA(isA<AuthenticationException>()),
    );
  });
}
