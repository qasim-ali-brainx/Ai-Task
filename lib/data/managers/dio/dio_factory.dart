import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../core/constants/api_end_points.dart';
import '../../../core/constants/app_constants.dart';

class DioFactory {
  const DioFactory._();

  static Dio create() {
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: ApiEndPoints.openAiBaseUrl,
        connectTimeout: const Duration(milliseconds: AppConstants.connectTimeoutMs),
        receiveTimeout: const Duration(milliseconds: AppConstants.receiveTimeoutMs),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppConstants.openAiApiKey}',
        },
      ),
    );
    dio.interceptors.add(_RetryOnServerErrorInterceptor(dio));
    if (kDebugMode) {
      dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    }
    return dio;
  }
}

class _RetryOnServerErrorInterceptor extends Interceptor {
  _RetryOnServerErrorInterceptor(this._dio);

  final Dio _dio;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final RequestOptions options = err.requestOptions;
    final int retries = (options.extra['retries'] as int?) ?? 0;
    final int? statusCode = err.response?.statusCode;
    final bool shouldRetry = statusCode != null &&
        statusCode >= 500 &&
        statusCode <= 599 &&
        retries < 2;

    if (!shouldRetry) {
      handler.next(err);
      return;
    }

    options.extra['retries'] = retries + 1;
    try {
      final Response<dynamic> response = await _dio.fetch<dynamic>(options);
      handler.resolve(response);
    } on DioException catch (retryError) {
      handler.next(retryError);
    }
  }
}
