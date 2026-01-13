import 'package:dio/dio.dart';
import 'package:vignesh_project_01/shared/others/providers/token_provider.dart';

class TokenInterceptor extends Interceptor {
  final TokenProvider tokenProvider;

  TokenInterceptor({required this.tokenProvider});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await tokenProvider.getAccessToken();

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }
}
