import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/register/data/models/register_dto.dart';

abstract class RegisterLocalDataSourceContract {
  Future<Result<RegisterDto>> register(Map<String, dynamic> body);
}
