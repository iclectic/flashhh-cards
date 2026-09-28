import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flashhh_cards/app/configuration/app_config.dart';
import 'package:flashhh_cards/core/errors/app_exception.dart';
import 'package:flashhh_cards/core/networking/api_client.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/fakes.dart';

void main() {
  test('network and server failures stay user-safe', () async {
    final logger = RecordingLogger();
    final client = _client(logger, (options) async {
      throw DioException(
        requestOptions: options,
        type: DioExceptionType.connectionError,
        error: 'SocketException: errno = 111',
      );
    });

    await expectLater(
      client.getJson('/v1/health'),
      throwsA(
        isA<NetworkException>().having(
          (error) => error.message.contains('errno'),
          'message hides transport detail',
          isFalse,
        ),
      ),
    );
    expect(logger.entries.single.message.contains('errno'), isFalse);
  });

  test('malformed JSON and unauthorized responses are rejected', () async {
    final logger = RecordingLogger();
    final malformed = _client(
      logger,
      (options) async => ResponseBody.fromString(
        '["not","an","object"]',
        200,
        headers: {
          Headers.contentTypeHeader: [Headers.jsonContentType],
        },
      ),
    );
    await expectLater(
      malformed.getJson('/v1/health'),
      throwsA(isA<UnexpectedException>()),
    );

    final unauthorized = _client(
      logger,
      (options) async => ResponseBody.fromString(
        '{"token":"secret-token","trace":"stack"}',
        401,
        headers: {
          Headers.contentTypeHeader: [Headers.jsonContentType],
        },
      ),
    );
    await expectLater(
      unauthorized.getJson('/v1/health'),
      throwsA(
        isA<AuthenticationException>().having(
          (error) => error.message.contains('secret-token'),
          'message',
          isFalse,
        ),
      ),
    );
  });

  test(
    'absolute insecure URLs are refused before the request is sent',
    () async {
      final logger = RecordingLogger();
      var called = false;
      final client = _client(logger, (options) async {
        called = true;
        return ResponseBody.fromString('{}', 200);
      }, environment: AppEnvironment.production);

      await expectLater(
        client.postJson('http://example.com/v1/generate'),
        throwsA(isA<UnexpectedException>()),
      );
      expect(called, isFalse);
    },
  );
}

DioApiClient _client(
  RecordingLogger logger,
  Future<ResponseBody> Function(RequestOptions options) handler, {
  AppEnvironment environment = AppEnvironment.development,
}) {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.flashhh.app/',
      responseType: ResponseType.json,
    ),
  );
  dio.httpClientAdapter = _ScriptedAdapter(handler);
  return DioApiClient(
    dio: dio,
    config: AppConfig(
      environment: environment,
      apiBaseUrl: Uri.parse('https://api.flashhh.app'),
      maxUploadBytes: 1024,
      maxGeneratedCards: 10,
    ),
    logger: logger,
  );
}

final class _ScriptedAdapter implements HttpClientAdapter {
  _ScriptedAdapter(this._handler);

  final Future<ResponseBody> Function(RequestOptions options) _handler;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) {
    return _handler(options);
  }

  @override
  void close({bool force = false}) {}
}
