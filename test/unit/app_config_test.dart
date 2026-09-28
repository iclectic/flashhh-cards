import 'package:flashhh_cards/app/configuration/app_config.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('accepts HTTPS and local development HTTP', () {
    final production = AppConfig.parse(
      environmentName: 'production',
      apiBaseUrl: 'https://api.flashhh.app',
      maxUploadBytes: 1024,
      maxGeneratedCards: 10,
    );
    final local = AppConfig.parse(
      environmentName: 'development',
      apiBaseUrl: 'http://127.0.0.1:8080',
      maxUploadBytes: 1024,
      maxGeneratedCards: 10,
    );

    expect(production.environment, AppEnvironment.production);
    expect(production.apiBaseUrl.scheme, 'https');
    expect(local.apiBaseUrl.host, '127.0.0.1');
  });

  test('rejects insecure, credentialed, and unknown configuration', () {
    expect(
      () => AppConfig.parse(
        environmentName: 'production',
        apiBaseUrl: 'http://api.flashhh.app',
        maxUploadBytes: 1024,
        maxGeneratedCards: 10,
      ),
      throwsStateError,
    );
    expect(
      () => AppConfig.parse(
        environmentName: 'staging',
        apiBaseUrl: 'http://localhost:8080',
        maxUploadBytes: 1024,
        maxGeneratedCards: 10,
      ),
      throwsStateError,
    );
    expect(
      () => AppConfig.parse(
        environmentName: 'development',
        apiBaseUrl: 'https://user:secret@api.flashhh.app',
        maxUploadBytes: 1024,
        maxGeneratedCards: 10,
      ),
      throwsStateError,
    );
    expect(
      () => AppConfig.parse(
        environmentName: 'test',
        apiBaseUrl: 'https://api.flashhh.app',
        maxUploadBytes: 1024,
        maxGeneratedCards: 10,
      ),
      throwsStateError,
    );
  });
}
