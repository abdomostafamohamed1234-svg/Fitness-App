import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/register/api/api_client/register_api_client.dart';
import 'package:flowery/features/register/data/datasources/register_local_data_source_contract.dart';
import 'package:flowery/features/register/data/models/register_dto.dart';
import 'package:injectable/injectable.dart';


@Injectable(as: RegisterLocalDataSourceContract)
class RegisterLocalDataSourceImpl implements RegisterLocalDataSourceContract {
  final RegisterApiClient _apiClient;
  RegisterLocalDataSourceImpl(this._apiClient);
 
  @override
  Future<Result<RegisterDto>> register(Map<String, dynamic> body) async {
    try {
      final data = await _apiClient.register(body);
      return Success<RegisterDto>(data: data);
    } on Exception catch (e) {
      return Error<RegisterDto>(exception: e);
    } catch (e) {
      return Error<RegisterDto>(exception: Exception(e.toString()));
    }
  }
}