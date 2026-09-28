import 'package:flashhh_cards/core/errors/app_exception.dart';
import 'package:flashhh_cards/core/storage/secure/flutter_secure_store.dart';
import 'package:flashhh_cards/core/storage/secure/secure_store.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_secure_storage/test/test_flutter_secure_storage_platform.dart';
import 'package:flutter_secure_storage_platform_interface/flutter_secure_storage_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('secure store writes, reads, and deletes tokens', () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    final memory = <String, String>{};
    FlutterSecureStoragePlatform.instance = TestFlutterSecureStoragePlatform(
      memory,
    );
    final store = FlutterSecureStore(const FlutterSecureStorage());

    await store.write(SecureStoreKeys.authToken, 'token-value');
    expect(await store.read(SecureStoreKeys.authToken), 'token-value');
    expect(memory[SecureStoreKeys.authToken], 'token-value');

    await store.delete(SecureStoreKeys.authToken);
    expect(await store.read(SecureStoreKeys.authToken), isNull);
    expect(
      () => store.write(SecureStoreKeys.refreshToken, ''),
      throwsA(isA<ValidationException>()),
    );
  });
}
