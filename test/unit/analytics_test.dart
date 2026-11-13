import 'package:flashhh_cards/core/analytics/analytics_client.dart';
import 'package:flashhh_cards/core/analytics/analytics_event.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/fakes.dart';

void main() {
  test('analytics drops personal and long free-text properties', () async {
    final logger = RecordingLogger();
    final client = LoggingAnalyticsClient(logger);

    await client.track(
      AnalyticsEvent.deckCreated,
      properties: {
        'email': 'person@example.com',
        'question': 'What is encapsulation?',
        'deckCount': 2,
        'note': 'x' * 200,
      },
    );

    final message = logger.entries.single.message;
    expect(message, contains('deck_created'));
    expect(message, contains('deckCount'));
    expect(message.contains('person@example.com'), isFalse);
    expect(message.contains('encapsulation'), isFalse);
    expect(message.contains('xxx'), isFalse);
  });

  test('the no-op client records nothing', () async {
    await const NoOpAnalyticsClient().track(AnalyticsEvent.pdfUploaded);
  });
}
