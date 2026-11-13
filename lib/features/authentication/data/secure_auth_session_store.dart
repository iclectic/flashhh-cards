import 'dart:convert';

import '../../../core/errors/app_exception.dart';
import '../../../core/storage/secure/secure_store.dart';
import '../../../core/utilities/app_logger.dart';
import '../domain/auth_session.dart';
import '../domain/user_account.dart';

/// Persists the optional session tokens outside SQLite.
final class SecureAuthSessionStore {
  const SecureAuthSessionStore({
    required SecureStore secureStore,
    required AppLogger logger,
  }) : _secureStore = secureStore,
       _logger = logger;

  final SecureStore _secureStore;
  final AppLogger _logger;

  Future<AuthSession?> read() async {
    try {
      final raw = await _secureStore.read(SecureStoreKeys.authToken);
      if (raw == null || raw.isEmpty) {
        return null;
      }
      final decoded = jsonDecode(raw);
      if (decoded is! Map<String, dynamic>) {
        await clear();
        return null;
      }
      return AuthSession.fromJson(decoded);
    } on FormatException catch (error, stackTrace) {
      _logger.warning(
        'Stored auth session was not valid JSON.',
        error: error,
        stackTrace: stackTrace,
      );
      await clear();
      return null;
    } on AppException {
      rethrow;
    } catch (error, stackTrace) {
      _logger.error(
        'The saved session could not be read.',
        error: error,
        stackTrace: stackTrace,
      );
      throw const AuthenticationException(
        message: 'The saved session could not be read.',
      );
    }
  }

  Future<void> write(AuthSession session) async {
    final refresh = session.refreshToken;
    await _secureStore.write(
      SecureStoreKeys.authToken,
      jsonEncode(session.toJson()),
    );
    if (refresh == null || refresh.isEmpty) {
      await _secureStore.delete(SecureStoreKeys.refreshToken);
      return;
    }
    await _secureStore.write(SecureStoreKeys.refreshToken, refresh);
  }

  Future<void> clear() async {
    await _secureStore.delete(SecureStoreKeys.authToken);
    await _secureStore.delete(SecureStoreKeys.refreshToken);
  }

  AuthSession mintLocal({
    required String accessToken,
    required AuthProvider provider,
    required DateTime issuedAt,
    String? refreshToken,
  }) {
    return AuthSession(
      accessToken: accessToken,
      refreshToken: refreshToken,
      provider: provider,
      issuedAt: issuedAt,
    );
  }
}
