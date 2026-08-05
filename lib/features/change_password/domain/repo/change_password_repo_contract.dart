import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/change_password/domain/entities/change_password_response_entity.dart';

abstract interface class ChangePasswordRepoContract {
  Future<Result<ChangePasswordResponseEntity>> changePassword(
    String password,
    String newPassword,
  );
}
