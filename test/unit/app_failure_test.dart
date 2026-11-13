import 'package:flashhh_cards/core/errors/app_exception.dart';
import 'package:flashhh_cards/core/errors/app_failure.dart';
import 'package:flashhh_cards/core/utilities/database_guard.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/fakes.dart';

void main() {
  test('user-facing failures omit causes and stack details', () {
    const cause = 'SocketException: Connection refused, errno = 111';
    const exception = NetworkException(
      message: 'You appear to be offline or the server could not be reached. Check your connection and try again.',
      cause: cause,
    );

    final failure = failureFor(exception);

    expect(failure.type, AppFailureType.network);
    expect(failure.message, exception.message);
    expect(failure.message.contains('errno'), isFalse);
    expect(failure.message.contains('Socket'), isFalse);
    expect(exception.toString().contains('errno'), isFalse);
  });

  test('unknown errors become a generic message', () {
    final failure = failureFor(StateError('sql: no such table users'));

    expect(failure.type, AppFailureType.unexpected);
    expect(failure.message, AppFailure.unexpectedMessage);
    expect(failure.message.contains('sql'), isFalse);
  });

  test('database guard logs the cause and hides it from the caller', () async {
    final logger = RecordingLogger();

    await expectLater(
      runDatabase(
        logger: logger,
        message: 'Your decks could not be loaded.',
        action: () => Future<void>.error(StateError('sqlite constraint')),
      ),
      throwsA(
        isA<DatabaseException>().having(
          (error) => error.message,
          'message',
          'Your decks could not be loaded.',
        ),
      ),
    );

    expect(logger.entries.single.error, isA<StateError>());
    expect(logger.entries.single.message, 'Your decks could not be loaded.');
  });
}
