import 'package:flowery/features/login/data/models/request/login_request_model.dart';
import 'package:flowery/features/login/data/models/response/login_response_model.dart';

import '../../../../../core/base/base_response.dart';

abstract class LoginRemoteDataSourceContract {
  Future<Result<LoginResponse>> login(LoginRequestModel request);
}