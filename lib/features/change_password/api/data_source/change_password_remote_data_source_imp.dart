import 'package:dio/dio.dart';
import 'package:flowery/config/exception_handlers/dio_exception_handler.dart';
import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/change_password/api/api_client/change_password_api_client.dart';
import 'package:flowery/features/change_password/data/data_source/change_password_remote_data_source_contract.dart';
import 'package:flowery/features/change_password/data/models/requestes/change_password_request.dart';
import 'package:flowery/features/change_password/data/models/responses/change_password_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ChangePasswordRemoteDataSourceContract)
class ChangePasswordRemoteDataSourceImp implements ChangePasswordRemoteDataSourceContract {
  final ChangePasswordApiClient apiClient;
  ChangePasswordRemoteDataSourceImp(this.apiClient);

  @override
  Future<Result<ChangePasswordResponse>> changePassword({
    required String password,
    required String newPassword,
  }) async {
    try {
      final response = await apiClient.changePassword(
        request: ChangePasswordRequest(
          password: password,
          newPassword: newPassword,
        ),
      );
      return Success<ChangePasswordResponse>(data: response);
    } on DioException catch (e) {
      return Error<ChangePasswordResponse>(
        exception: await DioExceptionHandler.handle(e),
      );
    }
  }
}
