import '../utilities/app_logger.dart';
import 'analytics_event.dart';

abstract interface class AnalyticsClient {
  Future<void> track(
    AnalyticsEvent event, {
    Map<String, Object?> properties = const {},
  });
}

final class NoOpAnalyticsClient implements AnalyticsClient {
  const NoOpAnalyticsClient();

  @override
  Future<void> track(
    AnalyticsEvent event, {
    Map<String, Object?> properties = const {},
  }) async {}
}

/// Development logger. It records event names, not personal data.
final class LoggingAnalyticsClient implements AnalyticsClient {
  const LoggingAnalyticsClient(this._logger);

  final AppLogger _logger;

  @override
  Future<void> track(
    AnalyticsEvent event, {
    Map<String, Object?> properties = const {},
  }) async {
    final safe = AnalyticsPrivacy.sanitize(properties);
    _logger.info('analytics ${event.wireName} $safe');
  }
}
