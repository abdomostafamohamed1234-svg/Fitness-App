import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/login/data/data_source/remote_data_source/login_remote_data_source_contract.dart';
import 'package:flowery/features/login/data/models/request/login_request_model.dart';
import 'package:flowery/features/login/data/models/response/login_response_model.dart';
import 'package:flowery/features/login/domain/entity/login_entity.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repo_contract/login_repo_contract.dart';

@Injectable(as: LoginRepoContract)
class LoginRepoImpl implements LoginRepoContract {
  final LoginRemoteDataSourceContract _remoteDataSource;

  LoginRepoImpl(this._remoteDataSource);

  @override
  Future<Result<LoginEntity>> login(
      LoginRequestModel request,
      ) async {
    final result = await _remoteDataSource.login(request);

    switch (result) {
      case Success<LoginResponse>():
        return Success(
          data: result.data?.toDomain(),
        );

      case Error<LoginResponse>():
        return Error(
          exception: result.exception,
        );
    }
  }
}