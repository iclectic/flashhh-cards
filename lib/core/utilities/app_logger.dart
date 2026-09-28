import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

enum LogLevel { debug, info, warning, error }

/// Logging seam. Messages may include technical detail; user interfaces must not.
abstract interface class AppLogger {
  void debug(String message, {Object? error, StackTrace? stackTrace});

  void info(String message, {Object? error, StackTrace? stackTrace});

  void warning(String message, {Object? error, StackTrace? stackTrace});

  void error(String message, {Object? error, StackTrace? stackTrace});
}

final class DeveloperAppLogger implements AppLogger {
  const DeveloperAppLogger({this.minimumLevel = LogLevel.debug});

  final LogLevel minimumLevel;

  @override
  void debug(String message, {Object? error, StackTrace? stackTrace}) {
    _write(LogLevel.debug, message, error, stackTrace);
  }

  @override
  void info(String message, {Object? error, StackTrace? stackTrace}) {
    _write(LogLevel.info, message, error, stackTrace);
  }

  @override
  void warning(String message, {Object? error, StackTrace? stackTrace}) {
    _write(LogLevel.warning, message, error, stackTrace);
  }

  @override
  void error(String message, {Object? error, StackTrace? stackTrace}) {
    _write(LogLevel.error, message, error, stackTrace);
  }

  void _write(
    LogLevel level,
    String message,
    Object? error,
    StackTrace? stackTrace,
  ) {
    if (kReleaseMode && level == LogLevel.debug) {
      return;
    }
    if (level.index < minimumLevel.index) {
      return;
    }
    developer.log(
      message,
      name: 'flashhh',
      level: switch (level) {
        LogLevel.debug => 500,
        LogLevel.info => 800,
        LogLevel.warning => 900,
        LogLevel.error => 1000,
      },
      error: error,
      stackTrace: stackTrace,
    );
  }
}
