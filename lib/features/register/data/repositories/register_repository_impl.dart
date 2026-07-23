import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/register/data/datasources/register_remote_data_source_contract.dart';
import 'package:flowery/features/register/data/models/register_dto_request.dart';
import 'package:flowery/features/register/domain/entities/register_entity.dart';
import 'package:flowery/features/register/domain/repositories/register_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RegisterRepository)
class RegisterRepositoryImpl implements RegisterRepository {
  final RegisterRemoteDataSourceContract _registerLocalDataSourceContract;
  RegisterRepositoryImpl(this._registerLocalDataSourceContract);

  @override
  Future<Result<RegisterEntity>> register(Map<String, dynamic> body) async {
    final response = await _registerLocalDataSourceContract.register(body);
    switch (response) {
      case Success<RegisterDto>():
        return Success<RegisterEntity>(data: response.data?.toModel());
      case Error<RegisterDto>():
        return Error<RegisterEntity>(exception: response.exception);
    }
  }
}
