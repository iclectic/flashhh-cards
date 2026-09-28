import 'package:dio/dio.dart';

import '../errors/app_exception.dart';

/// Maps transport failures to user-safe exceptions.
///
/// Response bodies are not copied into the exception. They can contain
/// document text or provider diagnostics.
AppException mapDioException(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.transformTimeout:
    case DioExceptionType.connectionError:
      return NetworkException(
        message: 'You appear to be offline or the server could not be reached. Check your connection and try again.',
        cause: error,
      );
    case DioExceptionType.badResponse:
      return _fromStatus(error);
    case DioExceptionType.cancel:
      return UnexpectedException(
        message: 'The request was cancelled.',
        cause: error,
      );
    case DioExceptionType.badCertificate:
      return const NetworkException(
        message: 'A secure connection to the server could not be established.',
      );
    case DioExceptionType.unknown:
      return NetworkException(
        message: 'You appear to be offline or the server could not be reached. Check your connection and try again.',
        cause: error,
      );
  }
}

AppException _fromStatus(DioException error) {
  final status = error.response?.statusCode;
  return switch (status) {
    401 => AuthenticationException(
      message: 'You need to sign in again before continuing.',
      cause: error,
    ),
    403 => const AuthenticationException(
      message: 'You do not have permission to do that.',
    ),
    429 => NetworkException(
      message: 'Flashhh is receiving too many requests right now. Wait a moment and try again.',
      statusCode: status,
      cause: error,
    ),
    _ => UnexpectedException(
      message: status != null && status >= 500
          ? 'The service is unavailable right now. Try again later.'
          : 'The server could not complete that request.',
      cause: error,
    ),
  };
}
