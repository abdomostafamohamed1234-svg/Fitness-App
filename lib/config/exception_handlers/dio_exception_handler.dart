import 'package:dio/dio.dart';

class DioExceptionHandler {
  DioExceptionHandler._();

  static Exception handle(DioException e,) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return Exception('Connection timeout');

      case DioExceptionType.sendTimeout:
        return Exception('Request timeout');

      case DioExceptionType.receiveTimeout:
        return Exception('Response timeout');

      case DioExceptionType.connectionError:
        return Exception('No internet connection');

      case DioExceptionType.badCertificate:
        return Exception('Bad certificate');

      case DioExceptionType.cancel:
        return Exception('Request cancelled');

      case DioExceptionType.badResponse:
        return Exception('Server error (${e.response?.statusCode})');

      case DioExceptionType.transformTimeout:
        return Exception('transform Timeout');

      case DioExceptionType.unknown:
        return Exception(e.message ?? 'Unexpected error');
    }
  }
}
