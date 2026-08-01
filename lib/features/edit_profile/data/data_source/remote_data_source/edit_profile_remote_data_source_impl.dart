import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/edit_profile/api/edit_profile_api_client.dart';
import 'package:flowery/features/edit_profile/data/data_source/remote_data_source/edit_profile_remote_data_source_contract.dart';
import 'package:flowery/features/edit_profile/data/models/request/edit_profile_request_model.dart';
import 'package:flowery/features/edit_profile/data/models/response/profile_response_model.dart';
import 'package:injectable/injectable.dart';

import '../../../../../config/exception_handlers/app_exception.dart';
import '../../../../../config/exception_handlers/dio_exception_handler.dart';

@Injectable(as: EditProfileRemoteDataSourceContract)
class EditProfileRemoteDataSourceImpl implements EditProfileRemoteDataSourceContract {
  final EditProfileApiClient _apiClient;
  EditProfileRemoteDataSourceImpl(this._apiClient);

  @override
  Future<Result<ProfileResponseModel>> getProfile() async {
    try {
      final response = await _apiClient.getProfile();
      return Success(data: response);
    } on DioException catch (e) {
      return Error(exception: await DioExceptionHandler.handle(e));
    } on Exception catch (e) {
      return Error(exception: AppException(e.toString()));
    }
  }

  @override
  Future<Result<ProfileResponseModel>> editProfile(
    EditProfileRequestModel request,
  ) async {
    try {
      final response = await _apiClient.editProfile(request);
      return Success(data: response);
    } on DioException catch (e) {
      return Error(exception: await DioExceptionHandler.handle(e));
    } on Exception catch (e) {
      return Error(exception: AppException(e.toString()));
    }
  }

  @override
  Future<Result<ProfileResponseModel>> uploadPhoto(File photo) async {
    try {
      final response = await _apiClient.uploadPhoto(photo);
      return Success(data: response);
    } on DioException catch (e) {
      return Error(exception: await DioExceptionHandler.handle(e));
    } on Exception catch (e) {
      return Error(exception: AppException(e.toString()));
    }
  }
}
