import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/login/data/models/request/login_request_model.dart';
import 'package:flowery/features/login/domain/entity/login_entity.dart';
import 'package:injectable/injectable.dart';

import '../repo_contract/login_repo_contract.dart';

@injectable
class LoginUseCase {
  final LoginRepoContract _loginRepo;

  LoginUseCase(this._loginRepo);

  Future<Result<LoginEntity>> call(
      LoginRequestModel request,
      ) {
    return _loginRepo.login(request);
  }
}