import 'package:flashhh_cards/core/storage/secure/secure_store.dart';
import 'package:flashhh_cards/core/utilities/app_logger.dart';
import 'package:flashhh_cards/core/utilities/clock.dart';
import 'package:flashhh_cards/core/utilities/id_generator.dart';

final class MemorySecureStore implements SecureStore {
  final values = <String, String>{};

  @override
  Future<String?> read(String key) async => values[key];

  @override
  Future<void> write(String key, String value) async {
    validateSecureEntry(key, value);
    values[key] = value;
  }

  @override
  Future<void> delete(String key) async {
    values.remove(key);
  }
}

final class FakeClock implements Clock {
  FakeClock(DateTime now) : _now = now.toUtc();

  DateTime _now;

  void set(DateTime now) => _now = now.toUtc();

  @override
  DateTime now() => _now;
}

final class SequentialIdGenerator implements IdGenerator {
  var _count = 0;

  @override
  String next() {
    _count += 1;
    return 'id-$_count';
  }
}

final class LogEntry {
  const LogEntry(this.level, this.message, this.error);

  final String level;
  final String message;
  final Object? error;
}

final class RecordingLogger implements AppLogger {
  final entries = <LogEntry>[];

  @override
  void debug(String message, {Object? error, StackTrace? stackTrace}) {
    entries.add(LogEntry('debug', message, error));
  }

  @override
  void info(String message, {Object? error, StackTrace? stackTrace}) {
    entries.add(LogEntry('info', message, error));
  }

  @override
  void warning(String message, {Object? error, StackTrace? stackTrace}) {
    entries.add(LogEntry('warning', message, error));
  }

  @override
  void error(String message, {Object? error, StackTrace? stackTrace}) {
    entries.add(LogEntry('error', message, error));
  }
}
