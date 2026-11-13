import 'auth_session.dart';
import 'user_account.dart';

/// Signs in without blocking guest use of the app.
///
/// Google and Apple need the Flashhh account service. Email linking works
/// on-device today: it upgrades the existing guest row in place so deck IDs
/// stay stable for a future sync.
abstract interface class AuthService {
  Future<({UserAccount account, AuthSession session})> linkEmail({
    required String email,
    required String displayName,
  });

  Future<UserAccount> signOutToGuest();

  Future<AuthSession?> readSession();
}
