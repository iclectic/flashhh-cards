import 'package:dio/dio.dart';

import '../../app/configuration/app_config.dart';
import '../errors/app_exception.dart';
import '../utilities/app_logger.dart';
import 'dio_exception_mapper.dart';

abstract interface class ApiClient {
  Future<Map<String, Object?>> getJson(
    String path, {
    Map<String, Object?>? query,
  });

  Future<Map<String, Object?>> postJson(String path, {Object? body});
}

final class DioApiClient implements ApiClient {
  DioApiClient({
    required Dio dio,
    required AppConfig config,
    required AppLogger logger,
  }) : _dio = dio,
       _config = config,
       _logger = logger;

  final Dio _dio;
  final AppConfig _config;
  final AppLogger _logger;

  @override
  Future<Map<String, Object?>> getJson(
    String path, {
    Map<String, Object?>? query,
  }) async {
    _assertPath(path);
    return _send(() => _dio.get<Object>(path, queryParameters: query));
  }

  @override
  Future<Map<String, Object?>> postJson(String path, {Object? body}) async {
    _assertPath(path);
    return _send(() => _dio.post<Object>(path, data: body));
  }

  Future<Map<String, Object?>> _send(
    Future<Response<Object>> Function() request,
  ) async {
    try {
      final response = await request();
      _assertAllowed(response.requestOptions.uri);
      return _readObject(response.data);
    } on DioException catch (error, stackTrace) {
      _logger.warning(
        'HTTP ${error.response?.statusCode ?? 'n/a'} ${error.type.name} '
        '${error.requestOptions.method} ${error.requestOptions.uri.host}'
        '${error.requestOptions.uri.path}',
        stackTrace: stackTrace,
      );
      throw mapDioException(error);
    } on AppException {
      rethrow;
    } catch (error, stackTrace) {
      _logger.error(
        'Unexpected API client failure',
        error: error,
        stackTrace: stackTrace,
      );
      throw UnexpectedException(cause: error);
    }
  }

  void _assertPath(String path) {
    final uri = Uri.tryParse(path);
    if (uri != null && uri.hasScheme) {
      _assertAllowed(uri);
    }
  }

  void _assertAllowed(Uri uri) {
    if (uri.scheme == 'https') {
      return;
    }
    final local = uri.host == 'localhost' || uri.host == '127.0.0.1';
    if (_config.environment == AppEnvironment.development &&
        uri.scheme == 'http' &&
        local) {
      return;
    }
    throw const UnexpectedException(
      message: 'Flashhh could not start that request.',
    );
  }

  Map<String, Object?> _readObject(Object? data) {
    if (data is Map<String, Object?>) {
      return data;
    }
    if (data is Map) {
      return data.map((key, value) => MapEntry(key.toString(), value));
    }
    throw const UnexpectedException(
      message: 'The server sent a response Flashhh could not read.',
    );
  }
}
