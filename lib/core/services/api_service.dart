import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:fpdart/fpdart.dart';
import 'package:vignesh_project_01/core/constants/app_urls.dart';
import 'package:vignesh_project_01/core/di/locator.dart';
import 'package:vignesh_project_01/core/exceptions/failure.dart';
import 'package:vignesh_project_01/core/interceptors/retry_interceptor.dart';
import 'package:vignesh_project_01/core/interceptors/token_interceptor.dart';
import 'package:vignesh_project_01/shared/others/providers/token_provider.dart';

class ApiService {
  late Dio _dio;
  Dio get dio => _dio;

  ApiService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppUrls.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
      ),
    );

    _dio.interceptors.addAll([
      TokenInterceptor(tokenProvider: locator<TokenProvider>()),
      RetryInterceptor(dio: _dio),
      LogInterceptor(requestBody: true, responseBody: true),
    ]);
  }

  Future<Either<Failure, Response>> get({
    required String route,
    Map<String, dynamic>? query,
  }) async {
    try {
      var response = await _dio.get(route, queryParameters: query);
      return Right(response);
    } on DioException catch (e) {
      return Left(convertError(e));
    } catch (e) {
      return Left(
        foundation.kDebugMode
            ? Failure(message: 'API Service GET catch block error : $e')
            : Failure(message: 'Something went wrong'),
      );
    }
  }

  Future<Either<Failure, Response>> post({
    required String route,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
  }) async {
    try {
      var response = await _dio.post(route, queryParameters: query, data: data);
      return Right(response);
    } on SocketException catch (e) {
      return Left(
        foundation.kDebugMode
            ? Failure(message: 'API Service POST socket error : $e')
            : Failure(message: 'Network error. Please try again'),
      );
    } on DioException catch (e) {
      return Left(convertError(e));
    } catch (e) {
      return Left(
        foundation.kDebugMode
            ? Failure(message: 'API Service GET catch block error : $e')
            : Failure(message: 'Something went wrong'),
      );
    }
  }

  Future<Either<Failure, Response>> put({
    required String route,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
  }) async {
    try {
      var response = await _dio.put(route, queryParameters: query, data: data);
      return Right(response);
    } on DioException catch (e) {
      return Left(convertError(e));
    } catch (e) {
      return Left(
        foundation.kDebugMode
            ? Failure(message: 'API Service GET catch block error : $e')
            : Failure(message: 'Something went wrong'),
      );
    }
  }

  Future<Either<Failure, Response>> delete({
    required String route,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
  }) async {
    try {
      var response = await _dio.delete(
        route,
        queryParameters: query,
        data: data,
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(convertError(e));
    } catch (e) {
      return Left(
        foundation.kDebugMode
            ? Failure(message: 'API Service GET catch block error : $e')
            : Failure(message: 'Something went wrong'),
      );
    }
  }

  Failure convertError(DioException? e) {
    if (e != null) {
      try {
        return Failure(
          message: e.response?.data['message'] ?? "Something went wrong",
          errorCode: e.response?.statusCode.toString(),
        );
      } catch (e) {
        return Failure(message: "Something went wrong ! : $e");
      }
    }

    return Failure(message: "Network error. Please try again");
  }
}
