import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/register/domain/entities/register_entity.dart';

abstract class RegisterRepository {
  Future<Result<RegisterEntity>> register(Map<String, dynamic> body);
}
