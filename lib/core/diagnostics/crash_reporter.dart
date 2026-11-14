import '../utilities/app_logger.dart';

/// Seam for a future Sentry / Crashlytics sink.
///
/// Implementations must not attach question, answer, email, file, or token
/// text. The logging sink only records exception types and messages.
abstract interface class CrashReporter {
  Future<void> recordError(
    Object error,
    StackTrace? stackTrace, {
    bool fatal = false,
  });

  Future<void> log(String message);
}

final class LoggingCrashReporter implements CrashReporter {
  const LoggingCrashReporter(this._logger);

  final AppLogger _logger;

  @override
  Future<void> recordError(
    Object error,
    StackTrace? stackTrace, {
    bool fatal = false,
  }) async {
    _logger.error(
      fatal ? 'Fatal error' : 'Non-fatal error',
      error: error,
      stackTrace: stackTrace,
    );
  }

  @override
  Future<void> log(String message) async {
    _logger.info(message);
  }
}

final class NoOpCrashReporter implements CrashReporter {
  const NoOpCrashReporter();

  @override
  Future<void> recordError(
    Object error,
    StackTrace? stackTrace, {
    bool fatal = false,
  }) async {}

  @override
  Future<void> log(String message) async {}
}
