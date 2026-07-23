import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/register/data/models/register_dto_request.dart';

abstract interface class RegisterRemoteDataSourceContract {
  Future<Result<RegisterDto>> register(Map<String, dynamic> body);
}
