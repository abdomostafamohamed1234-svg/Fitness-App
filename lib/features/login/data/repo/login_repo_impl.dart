import 'package:flowery/config/api/api_keys.dart';
import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/login/data/data_source/remote_data_source/login_remote_data_source_contract.dart';
import 'package:flowery/features/login/data/models/request/login_request_model.dart';
import 'package:flowery/features/login/data/models/response/login_response_model.dart';
import 'package:flowery/features/login/domain/entity/login_entity.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repo_contract/login_repo_contract.dart';

@Injectable(as: LoginRepoContract)
class LoginRepoImpl implements LoginRepoContract {
  final LoginRemoteDataSourceContract _remoteDataSource;
  final FlutterSecureStorage _secureStorage;

  LoginRepoImpl(this._remoteDataSource, this._secureStorage);

  @override
  Future<Result<LoginEntity>> login(
    LoginRequestModel request,
  ) async {
    final result = await _remoteDataSource.login(request);
    switch (result) {
      case Success<LoginResponse>():
        final entity = result.data?.toDomain();

        if (entity != null) {
          await _secureStorage.write(
            key: ApiKeys.token,
            value: entity.token,
          );
        }

        return Success(data: entity);
      case Error<LoginResponse>():
        return Error(
          exception: result.exception,
        );
    }
  }
}