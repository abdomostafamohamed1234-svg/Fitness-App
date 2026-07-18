import 'package:dio/dio.dart';
import 'package:flowery/config/api/api_endpoints.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/api_interceptor.dart';

@module
abstract class DiModule {
  @preResolve
  Future<SharedPreferences> sharedPreferences() =>
      SharedPreferences.getInstance();

  @lazySingleton
  FlutterSecureStorage secureStorage() => const FlutterSecureStorage();

  @singleton
  Dio dio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: AppEndPoints.baseUrl,
        sendTimeout: const Duration(seconds: 45),
        connectTimeout: const Duration(seconds: 45),
      ),
    );
    dio.interceptors.add(ApiInterceptor(dio: dio, fss: secureStorage()));
    return dio;
  }

  @Named('mealsDio')
  @singleton
  Dio mealsDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: AppEndPoints.baseUrl,
        sendTimeout: const Duration(seconds: 45),
        connectTimeout: const Duration(seconds: 45),
      ),
    );
    dio.interceptors.add(ApiInterceptor(dio: dio, fss: secureStorage()));
    return dio;
  }
}
