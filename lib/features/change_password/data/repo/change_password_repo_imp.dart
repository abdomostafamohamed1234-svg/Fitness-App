import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/change_password/data/data_source/change_password_local_data_source_contract.dart';
import 'package:flowery/features/change_password/data/data_source/change_password_remote_data_source_contract.dart';
import 'package:flowery/features/change_password/data/models/responses/change_password_response.dart';
import 'package:flowery/features/change_password/domain/entities/change_password_response_entity.dart';
import 'package:flowery/features/change_password/domain/repo/change_password_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ChangePasswordRepoContract)
class ChangePasswordRepoImp implements ChangePasswordRepoContract {
  final ChangePasswordRemoteDataSourceContract ds;
  final ChangePasswordLocalDataSourceContract localDs;
  ChangePasswordRepoImp(this.ds,this.localDs);

  @override
  Future<Result<ChangePasswordResponseEntity>> changePassword(
    String password,
    String newPassword,
  ) async {
    final response = await ds.changePassword(
      password: password,
      newPassword: newPassword,
    );
    switch (response) {
      case Success<ChangePasswordResponse>():
       await localDs.updateUswerToken(response.data?.token ?? "");
        return Success<ChangePasswordResponseEntity>(
          data: response.data?.toEntity(),
        );
      case Error<ChangePasswordResponse>():
        return Error<ChangePasswordResponseEntity>(
          exception: response.exception,
        );
    }
  }
}
