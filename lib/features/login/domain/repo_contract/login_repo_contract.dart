import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/login/data/models/request/login_request_model.dart';
import 'package:flowery/features/login/domain/entity/login_entity.dart';

abstract class LoginRepoContract {
  Future<Result<LoginEntity>> login(LoginRequestModel request);
}