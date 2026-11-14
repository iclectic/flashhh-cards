import 'package:dio/dio.dart';

import '../../app/configuration/app_config.dart';
import '../utilities/app_logger.dart';

/// Seam for a hosted crash sink (Sentry/Crashlytics or Flashhh ingest).
///
/// Implementations must not attach question, answer, email, file, or token
/// text. Payloads stay limited to exception type, a scrubbed message, and a
/// truncated stack.
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

/// Posts scrubbed diagnostics to [AppConfig.crashIngestUrl] when configured.
///
/// Failures are swallowed so crash reporting never takes down the app.
final class RemoteCrashReporter implements CrashReporter {
  RemoteCrashReporter({
    required Uri ingestUrl,
    required AppLogger logger,
    Dio? dio,
  }) : _ingestUrl = ingestUrl,
       _logger = logger,
       _dio =
           dio ??
           Dio(
             BaseOptions(
               connectTimeout: const Duration(seconds: 8),
               receiveTimeout: const Duration(seconds: 8),
               sendTimeout: const Duration(seconds: 8),
               headers: const {
                 'Accept': 'application/json',
                 'Content-Type': 'application/json',
               },
             ),
           );

  final Uri _ingestUrl;
  final AppLogger _logger;
  final Dio _dio;

  @override
  Future<void> recordError(
    Object error,
    StackTrace? stackTrace, {
    bool fatal = false,
  }) async {
    try {
      await _dio.postUri<Object>(
        _ingestUrl,
        data: {
          'fatal': fatal,
          'errorType': error.runtimeType.toString(),
          'message': scrubCrashText(error.toString()),
          'stack': scrubCrashText(
            stackTrace?.toString() ?? '',
            maxLength: 2000,
          ),
          'app': 'flashhh_cards',
        },
      );
    } catch (error, stackTrace) {
      _logger.warning(
        'Crash ingest failed',
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<void> log(String message) async {
    try {
      await _dio.postUri<Object>(
        _ingestUrl,
        data: {
          'fatal': false,
          'errorType': 'log',
          'message': scrubCrashText(message),
          'stack': '',
          'app': 'flashhh_cards',
        },
      );
    } catch (_) {
      // Ignore log-ingest failures.
    }
  }
}

/// Fan-out reporter used when both local logging and remote ingest are active.
final class CompositeCrashReporter implements CrashReporter {
  const CompositeCrashReporter(this._reporters);

  final List<CrashReporter> _reporters;

  @override
  Future<void> recordError(
    Object error,
    StackTrace? stackTrace, {
    bool fatal = false,
  }) async {
    for (final reporter in _reporters) {
      await reporter.recordError(error, stackTrace, fatal: fatal);
    }
  }

  @override
  Future<void> log(String message) async {
    for (final reporter in _reporters) {
      await reporter.log(message);
    }
  }
}

CrashReporter buildCrashReporter({
  required AppConfig config,
  required AppLogger logger,
}) {
  final remoteUrl = config.crashIngestUrl;
  final logging = LoggingCrashReporter(logger);
  if (remoteUrl == null) {
    return logging;
  }
  return CompositeCrashReporter([
    logging,
    RemoteCrashReporter(ingestUrl: remoteUrl, logger: logger),
  ]);
}

/// Removes emails and trims long free-form text before leaving the device.
String scrubCrashText(String raw, {int maxLength = 240}) {
  var text = raw.replaceAll(
    RegExp(r'[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}', caseSensitive: false),
    '[redacted-email]',
  );
  text = text.replaceAll(
    RegExp(r'(Bearer\s+)[A-Za-z0-9._\-]+', caseSensitive: false),
    r'$1[redacted]',
  );
  text = text.replaceAll(RegExp(r'\s+'), ' ').trim();
  if (text.length <= maxLength) {
    return text;
  }
  return '${text.substring(0, maxLength)}…';
}
