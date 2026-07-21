import 'package:dio/dio.dart';
import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/login/api/login_api_client.dart';
import 'package:flowery/features/login/data/data_source/remote_data_source/login_remote_data_source_contract.dart';
import 'package:flowery/features/login/data/models/request/login_request_model.dart';
import 'package:flowery/features/login/data/models/response/login_response_model.dart';
import 'package:injectable/injectable.dart';

import '../../../../../config/exception_handlers/app_exception.dart';
import '../../../../../config/exception_handlers/dio_exception_handler.dart';
@Injectable(as: LoginRemoteDataSourceContract)
class LoginRemoteDataSourceImpl implements LoginRemoteDataSourceContract{
  final LoginApiClient _apiClient;
  LoginRemoteDataSourceImpl(this._apiClient);
  @override
  Future<Result<LoginResponse>> login(
      LoginRequestModel request,
      ) async {
    try {
      final response = await _apiClient.login(request);

      return Success(data: response);
    } on DioException catch (e) {
      return Error(
        exception: await DioExceptionHandler.handle(e),
      );
    } on Exception catch (e) {
      return Error(exception: AppException(e.toString()));
    }
  }
}