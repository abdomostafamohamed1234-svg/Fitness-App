import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/change_password/data/models/responses/change_password_response.dart';

abstract interface class ChangePasswordRemoteDataSourceContract {
  Future<Result<ChangePasswordResponse>> changePassword({
    required String password,
   required String newPassword,
  });
}
