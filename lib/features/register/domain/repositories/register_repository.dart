import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/register/domain/entities/register_model.dart';

abstract class RegisterRepository {
  Future<Result<RegisterModel>> register(Map<String, dynamic> body);
}
