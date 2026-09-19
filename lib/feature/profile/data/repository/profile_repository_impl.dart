import 'package:dio/dio.dart';
import 'package:flowery/feature/profile/api/api/profile_api_client.dart';
import 'package:flowery/feature/profile/domain/entities/profile_entity.dart';
import 'package:flowery/feature/profile/domain/repository/profile_%20repository_contract.dart';
import 'package:injectable/injectable.dart';
import 'package:flowery/core/base/base_response.dart';


@Injectable(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl(this._apiClient);

  final ProfileApiClient _apiClient;

  @override
  Future<Result<ProfileEntity>> getProfile() async {
    try {
      final response = await _apiClient.getProfile();
      return Success(data: response.toEntity());
    } on DioException catch (exception) {
      return Error(exception: exception);
    } catch (exception) {
      return Error(exception: exception is Exception ? exception : Exception(exception.toString()));
    }
  }
}