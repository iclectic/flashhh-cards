import 'package:flashhh_cards/app/configuration/app_config.dart';
import 'package:flashhh_cards/core/diagnostics/crash_reporter.dart';
import 'package:flashhh_cards/core/networking/connectivity_status.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/fakes.dart';

void main() {
  test('fake connectivity reports offline updates', () async {
    final status = FakeConnectivityStatus(NetworkReachability.online);
    expect(await status.current(), NetworkReachability.online);

    final future = status.watch().first;
    status.set(NetworkReachability.offline);
    expect(await future, NetworkReachability.offline);
    expect(await status.current(), NetworkReachability.offline);
  });

  test('logging crash reporter records without throwing', () async {
    final logger = RecordingLogger();
    final sink = LoggingCrashReporter(logger);
    await sink.recordError(StateError('boom'), StackTrace.current);
    await sink.log('checkpoint');
    expect(
      logger.entries.where((entry) => entry.level == 'error'),
      isNotEmpty,
    );
    expect(
      logger.entries.any(
        (entry) => entry.level == 'info' && entry.message == 'checkpoint',
      ),
      isTrue,
    );
  });

  test('scrubCrashText redacts emails and truncates', () {
    final scrubbed = scrubCrashText(
      'failed for user@example.com with a very long diagnostic payload ${'x' * 300}',
    );
    expect(scrubbed.contains('user@example.com'), isFalse);
    expect(scrubbed.contains('[redacted-email]'), isTrue);
    expect(scrubbed.length <= 241, isTrue);
  });

  test('buildCrashReporter stays local without ingest URL', () {
    final config = AppConfig.parse(
      environmentName: 'development',
      apiBaseUrl: 'http://127.0.0.1:8080',
      maxUploadBytes: 1024,
      maxGeneratedCards: 10,
    );
    final reporter = buildCrashReporter(
      config: config,
      logger: RecordingLogger(),
    );
    expect(reporter, isA<LoggingCrashReporter>());
  });

  test('buildCrashReporter composites when ingest URL is set', () {
    final config = AppConfig.parse(
      environmentName: 'development',
      apiBaseUrl: 'http://127.0.0.1:8080',
      maxUploadBytes: 1024,
      maxGeneratedCards: 10,
      crashIngestUrl: 'http://127.0.0.1:8080/v1/diagnostics/crash',
    );
    final reporter = buildCrashReporter(
      config: config,
      logger: RecordingLogger(),
    );
    expect(reporter, isA<CompositeCrashReporter>());
  });
}
