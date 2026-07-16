import 'package:dio/dio.dart';
import 'package:flowery/config/api/api_keys.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiInterceptor extends Interceptor {
  final Dio dio;
  final FlutterSecureStorage fss;
  ApiInterceptor({required this.dio, required this.fss});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final String? token = await fss.read(key: ApiKeys.token);
    if (token != null && token.isNotEmpty) {
      options.headers[ApiKeys.authorization] = '${ApiKeys.bearer} $token';
    }
    super.onRequest(options, handler);
  }
}
