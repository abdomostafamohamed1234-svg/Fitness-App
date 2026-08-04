import 'package:dio/dio.dart';
import 'package:flowery/config/api/api_keys.dart';
import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/feature/logout/api/api_client/logout_api_client.dart';
import 'package:flowery/feature/logout/domian/repository/logout_repository_contract.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LogoutRepository)
class LogoutRepositoryImpl implements LogoutRepository {
  LogoutRepositoryImpl(this._apiClient, this._secureStorage);

  final LogoutApiClient _apiClient;
  final FlutterSecureStorage _secureStorage;

  @override
  Future<Result<void>> logout() async {
    try {
      await _apiClient.logout();

      await _secureStorage.delete(key: ApiKeys.token);

      return const Success(data: null);
    } on DioException catch (exception) {
      return Error(exception: exception);
    } catch (exception) {
      return Error(
        exception: exception is Exception ? exception : Exception(exception.toString()),
      );
    }
  }
}