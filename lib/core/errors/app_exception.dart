import 'app_failure.dart';

/// Application error with a message that is safe to show to a person.
///
/// [cause] is for logs only. [toString] intentionally omits it.
sealed class AppException implements Exception {
  const AppException({required this.type, required this.message, this.cause});

  final AppFailureType type;
  final String message;
  final Object? cause;

  @override
  String toString() => '$runtimeType: $message';
}

final class NetworkException extends AppException {
  const NetworkException({required super.message, super.cause, this.statusCode})
    : super(type: AppFailureType.network);

  final int? statusCode;
}

final class AuthenticationException extends AppException {
  const AuthenticationException({required super.message, super.cause})
    : super(type: AppFailureType.authentication);
}

final class DatabaseException extends AppException {
  const DatabaseException({required super.message, super.cause})
    : super(type: AppFailureType.database);
}

final class DocumentException extends AppException {
  const DocumentException({required super.message, super.cause})
    : super(type: AppFailureType.document);
}

final class AiGenerationException extends AppException {
  const AiGenerationException({required super.message, super.cause})
    : super(type: AppFailureType.aiGeneration);
}

final class ValidationException extends AppException {
  const ValidationException({required super.message, super.cause})
    : super(type: AppFailureType.validation);
}

final class UnexpectedException extends AppException {
  const UnexpectedException({
    super.message = AppFailure.unexpectedMessage,
    super.cause,
  }) : super(type: AppFailureType.unexpected);
}

extension AppExceptionFailure on AppException {
  AppFailure toFailure() => AppFailure(type: type, message: message);
}

/// Maps any thrown value to a message that is safe to show in the interface.
AppFailure failureFor(Object error) {
  if (error is AppFailure) {
    return error;
  }
  if (error is AppException) {
    return error.toFailure();
  }
  return const AppFailure(
    type: AppFailureType.unexpected,
    message: AppFailure.unexpectedMessage,
  );
}
