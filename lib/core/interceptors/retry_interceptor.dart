import 'dart:async';

import 'package:dio/dio.dart';

/// Retries requests that are safe to repeat and likely to succeed on a
/// second try.
///
/// - Only idempotent methods ([_retryableMethods]); a POST is never resent,
///   since the server may already have applied it (e.g. a sent message).
/// - Only fast, transient failures: a dropped connection or a gateway error.
///   Timeouts are not retried: they mean the server is down or overloaded,
///   and retrying only makes the user wait longer.
/// - Exponential backoff: [baseDelay], then 2x, ...
class RetryInterceptor extends Interceptor {
  RetryInterceptor({
    required this.dio,
    this.maxRetries = 2,
    this.baseDelay = const Duration(milliseconds: 500),
  });

  final Dio dio;
  final int maxRetries;
  final Duration baseDelay;

  static const _attemptKey = 'retry_attempt';
  static const _retryableMethods = {'GET', 'HEAD'};
  static const _retryableStatusCodes = {502, 503, 504};

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final options = err.requestOptions;
    final attempt = options.extra[_attemptKey] as int? ?? 0;

    if (attempt >= maxRetries || !shouldRetry(err)) {
      handler.next(err);
      return;
    }

    options.extra[_attemptKey] = attempt + 1;
    await Future<void>.delayed(baseDelay * (1 << attempt));

    try {
      // Runs the full interceptor chain again, so this interceptor handles
      // any further retries for the same request.
      handler.resolve(await dio.fetch<dynamic>(options));
    } on DioException catch (e) {
      // Report the latest failure, not the first one.
      handler.next(e);
    }
  }

  static bool shouldRetry(DioException err) {
    final method = err.requestOptions.method.toUpperCase();
    if (!_retryableMethods.contains(method)) return false;

    return switch (err.type) {
      DioExceptionType.connectionError => true,
      DioExceptionType.badResponse => _retryableStatusCodes.contains(
        err.response?.statusCode,
      ),
      _ => false,
    };
  }
}
