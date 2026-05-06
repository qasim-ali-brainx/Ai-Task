import 'dart:io';

import 'package:dio/dio.dart';

import 'failure.dart';

class ErrorHandler {
  const ErrorHandler._();

  static Failure mapException(Object error) {
    if (error is DioException) {
      final int? statusCode = error.response?.statusCode;
      if (statusCode == 400) {
        return const Failure(
          'The request was invalid. Please try uploading again.',
          statusCode: 400,
        );
      }
      if (statusCode == 401) {
        return const Failure('API key is invalid or expired.', statusCode: 401);
      }
      if (statusCode == 429) {
        return const Failure(
          'Too many requests. Please wait a moment and try again.',
          statusCode: 429,
        );
      }
      if (statusCode == 500 || statusCode == 502 || statusCode == 503) {
        return Failure(
          'OpenAI service is temporarily unavailable. Try again later.',
          statusCode: statusCode,
        );
      }
      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.sendTimeout ||
          error.type == DioExceptionType.receiveTimeout) {
        return const Failure(
          'The request timed out. The brief may be too large — try a shorter one.',
        );
      }
      if (error.error is SocketException) {
        return const Failure(
          'No internet connection. Please check your network.',
        );
      }
      return Failure(
        'Something went wrong. Please try again.',
        statusCode: statusCode,
      );
    }
    if (error is FormatException) {
      return const Failure('Unexpected response format. Please try again.');
    }
    if (error is SocketException) {
      return const Failure('No internet connection. Please check your network.');
    }
    return const Failure('Something went wrong. Please try again.');
  }
}
