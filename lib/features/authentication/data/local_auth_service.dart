import '../../../core/analytics/analytics_client.dart';
import '../../../core/analytics/analytics_event.dart';
import '../../../core/errors/app_exception.dart';
import '../../../core/utilities/clock.dart';
import '../../../core/utilities/id_generator.dart';
import '../domain/account_repository.dart';
import '../domain/auth_service.dart';
import '../domain/auth_session.dart';
import '../domain/user_account.dart';
import 'secure_auth_session_store.dart';

/// Device-local email linking. Google/Apple wait on the account service.
final class LocalAuthService implements AuthService {
  LocalAuthService({
    required AccountRepository accounts,
    required SecureAuthSessionStore sessions,
    required IdGenerator ids,
    required Clock clock,
    required AnalyticsClient analytics,
  }) : _accounts = accounts,
       _sessions = sessions,
       _ids = ids,
       _clock = clock,
       _analytics = analytics;

  final AccountRepository _accounts;
  final SecureAuthSessionStore _sessions;
  final IdGenerator _ids;
  final Clock _clock;
  final AnalyticsClient _analytics;

  @override
  Future<({UserAccount account, AuthSession session})> linkEmail({
    required String email,
    required String displayName,
  }) async {
    final account = await _accounts.linkEmail(
      email: email,
      displayName: displayName,
    );
    final session = _sessions.mintLocal(
      accessToken: _ids.next(),
      refreshToken: _ids.next(),
      provider: AuthProvider.email,
      issuedAt: _clock.now(),
    );
    await _sessions.write(session);
    await _analytics.track(
      AnalyticsEvent.accountLinked,
      properties: {'provider': AuthProvider.email.name},
    );
    return (account: account, session: session);
  }

  @override
  Future<UserAccount> signOutToGuest() async {
    final account = await _accounts.revertToGuest();
    await _sessions.clear();
    await _analytics.track(AnalyticsEvent.accountSignedOut);
    return account;
  }

  @override
  Future<AuthSession?> readSession() => _sessions.read();

  /// Reserved for Phase 9 cloud providers. Not offered in the UI yet.
  Future<Never> signInWithGoogle() {
    throw const AuthenticationException(
      message:
          'Google sign-in needs the Flashhh account service. '
          'You can link an email on this device for now.',
    );
  }

  Future<Never> signInWithApple() {
    throw const AuthenticationException(
      message:
          'Apple sign-in needs the Flashhh account service. '
          'You can link an email on this device for now.',
    );
  }
}
