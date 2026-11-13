import '../errors/app_exception.dart';
import 'app_logger.dart';

/// Logs the underlying database error and throws a user-safe [DatabaseException].
Future<T> runDatabase<T>({
  required AppLogger logger,
  required String message,
  required Future<T> Function() action,
}) async {
  try {
    return await action();
  } on AppException {
    rethrow;
  } catch (error, stackTrace) {
    logger.error(message, error: error, stackTrace: stackTrace);
    throw DatabaseException(message: message, cause: error);
  }
}
