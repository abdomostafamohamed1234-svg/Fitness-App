import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/register/domain/entities/register_entity.dart';
import 'package:flowery/features/register/domain/repositories/register_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterUsecase {
  final RegisterRepository _registerRepository;
  RegisterUsecase(this._registerRepository);


  Future<Result<RegisterEntity>> invoke(Map<String, dynamic> body)  {
    return  _registerRepository.register(body);
  }
}
