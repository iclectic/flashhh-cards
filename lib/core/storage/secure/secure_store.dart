import '../../errors/app_exception.dart';

/// Storage for credentials. Values must not be written to the database or logs.
abstract interface class SecureStore {
  Future<String?> read(String key);

  Future<void> write(String key, String value);

  Future<void> delete(String key);
}

abstract final class SecureStoreKeys {
  static const authToken = 'auth_token';
  static const refreshToken = 'refresh_token';
}

void validateSecureEntry(String key, String value) {
  if (key.trim().isEmpty) {
    throw const ValidationException(message: 'The secure item has no name.');
  }
  if (value.isEmpty) {
    throw const ValidationException(message: 'The secure item is empty.');
  }
}
