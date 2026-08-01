import 'package:dio/dio.dart';
import 'package:flowery/config/api/api_keys.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiInterceptor extends Interceptor {
  final Dio dio;
  final FlutterSecureStorage fss;
  ApiInterceptor({required this.dio, required this.fss});

  // TODO(remove-before-commit): temporary hardcoded token for manual testing
  // until the login flow is wired up to populate secure storage.
  static const String _tempTestToken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiNmE1ZWVhYzhlYTk2NThjZWEyNDgzODE1IiwiaWF0IjoxNzg1NTI1MjM2fQ.cmiY7VYAI70dq5XpX9_SuQplVujS3_jSQwGMVfBQfiw';

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final String token = await fss.read(key: ApiKeys.token) ?? _tempTestToken;
    if (token.isNotEmpty) {
      options.headers[ApiKeys.authorization] = '${ApiKeys.bearer} $token';
    }
    super.onRequest(options, handler);
  }
}
