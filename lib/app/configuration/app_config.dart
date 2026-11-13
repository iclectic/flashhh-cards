enum AppEnvironment { development, staging, production }

/// Runtime configuration. Secrets are not part of this object.
///
/// Override values at build time:
/// `--dart-define=APP_ENV=production`
/// `--dart-define=API_BASE_URL=https://api.example.com`
/// `--dart-define=MAX_UPLOAD_BYTES=20971520`
/// `--dart-define=MAX_GENERATED_CARDS=40`
final class AppConfig {
  const AppConfig({
    required this.environment,
    required this.apiBaseUrl,
    required this.maxUploadBytes,
    required this.maxGeneratedCards,
  });

  final AppEnvironment environment;
  final Uri apiBaseUrl;
  final int maxUploadBytes;
  final int maxGeneratedCards;

  bool get isProduction => environment == AppEnvironment.production;

  factory AppConfig.fromEnvironment() {
    return AppConfig.parse(
      environmentName: const String.fromEnvironment(
        'APP_ENV',
        defaultValue: 'development',
      ),
      apiBaseUrl: const String.fromEnvironment(
        'API_BASE_URL',
        defaultValue: 'https://api.flashhh.app',
      ),
      maxUploadBytes: const int.fromEnvironment(
        'MAX_UPLOAD_BYTES',
        defaultValue: 20 * 1024 * 1024,
      ),
      maxGeneratedCards: const int.fromEnvironment(
        'MAX_GENERATED_CARDS',
        defaultValue: 40,
      ),
    );
  }

  factory AppConfig.parse({
    required String environmentName,
    required String apiBaseUrl,
    required int maxUploadBytes,
    required int maxGeneratedCards,
  }) {
    final environment = _environment(environmentName);
    final uri = _apiBaseUrl(apiBaseUrl, environment);
    if (maxUploadBytes < 1) {
      throw StateError('MAX_UPLOAD_BYTES must be positive.');
    }
    if (maxGeneratedCards < 1 || maxGeneratedCards > 100) {
      throw StateError('MAX_GENERATED_CARDS must be between 1 and 100.');
    }
    return AppConfig(
      environment: environment,
      apiBaseUrl: uri,
      maxUploadBytes: maxUploadBytes,
      maxGeneratedCards: maxGeneratedCards,
    );
  }

  static AppEnvironment _environment(String name) {
    return switch (name) {
      'development' => AppEnvironment.development,
      'staging' => AppEnvironment.staging,
      'production' => AppEnvironment.production,
      _ => throw StateError('Unknown APP_ENV "$name".'),
    };
  }

  /// Production and staging require HTTPS.
  /// Development may use HTTP only for localhost, so a local backend can run.
  static Uri _apiBaseUrl(String raw, AppEnvironment environment) {
    final uri = Uri.tryParse(raw.trim());
    if (uri == null || uri.host.isEmpty || !uri.hasScheme) {
      throw StateError('API_BASE_URL is not a valid absolute URL.');
    }
    if (uri.userInfo.isNotEmpty) {
      throw StateError('API_BASE_URL must not contain credentials.');
    }
    final localHost = uri.host == 'localhost' || uri.host == '127.0.0.1';
    final https = uri.scheme == 'https';
    final localHttp =
        environment == AppEnvironment.development &&
        uri.scheme == 'http' &&
        localHost;
    if (!https && !localHttp) {
      throw StateError('API_BASE_URL must use HTTPS.');
    }
    return uri;
  }
}
