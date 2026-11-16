import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vignesh_project_01/core/interceptors/retry_interceptor.dart';

/// Fails every request the same way and counts attempts.
class _FailingAdapter implements HttpClientAdapter {
  _FailingAdapter({this.statusCode, this.type});

  final int? statusCode;
  final DioExceptionType? type;
  int attempts = 0;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    attempts++;
    final type = this.type;
    if (type != null) {
      throw DioException(requestOptions: options, type: type);
    }
    return ResponseBody.fromString('{}', statusCode!);
  }

  @override
  void close({bool force = false}) {}
}

Future<(_FailingAdapter, DioException)> _run(
  String method, {
  int? statusCode,
  DioExceptionType? type,
}) async {
  final adapter = _FailingAdapter(statusCode: statusCode, type: type);
  final dio = Dio(BaseOptions(baseUrl: 'http://test'))
    ..httpClientAdapter = adapter;
  dio.interceptors.add(RetryInterceptor(dio: dio, baseDelay: Duration.zero));

  try {
    await dio.request<dynamic>('/x', options: Options(method: method));
    fail('expected a DioException');
  } on DioException catch (e) {
    return (adapter, e);
  }
}

void main() {
  test('GET retries a dropped connection twice, then fails', () async {
    final (adapter, _) = await _run(
      'GET',
      type: DioExceptionType.connectionError,
    );
    expect(adapter.attempts, 3);
  });

  test('POST is never retried (no duplicate messages)', () async {
    final (adapter, _) = await _run(
      'POST',
      type: DioExceptionType.connectionError,
    );
    expect(adapter.attempts, 1);
  });

  test('timeouts are not retried', () async {
    for (final type in [
      DioExceptionType.connectionTimeout,
      DioExceptionType.receiveTimeout,
    ]) {
      final (adapter, _) = await _run('GET', type: type);
      expect(adapter.attempts, 1, reason: '$type');
    }
  });

  test('gateway errors are retried, plain 500 is not', () async {
    expect((await _run('GET', statusCode: 503)).$1.attempts, 3);
    expect((await _run('GET', statusCode: 500)).$1.attempts, 1);
    expect((await _run('GET', statusCode: 404)).$1.attempts, 1);
  });

  test('reports the latest error', () async {
    final (_, error) = await _run('GET', statusCode: 502);
    expect(error.requestOptions.extra['retry_attempt'], 2);
    expect(error.response?.statusCode, 502);
  });
}
