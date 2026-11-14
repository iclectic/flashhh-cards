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
}
