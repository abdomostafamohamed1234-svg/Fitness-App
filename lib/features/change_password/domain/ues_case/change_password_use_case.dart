import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/change_password/domain/entities/change_password_response_entity.dart';
import 'package:flowery/features/change_password/domain/repo/change_password_repo_contract.dart';
import 'package:injectable/injectable.dart';


@injectable
class ChangePasswordUseCase {
  final ChangePasswordRepoContract repo;
  ChangePasswordUseCase(this.repo);

  Future<Result<ChangePasswordResponseEntity>> call(
    String password,
    String newPassword,
  ) => repo.changePassword(password, newPassword);
}
