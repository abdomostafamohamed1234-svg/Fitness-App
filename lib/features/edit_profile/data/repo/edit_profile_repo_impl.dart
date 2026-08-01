import 'dart:io';

import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/edit_profile/data/data_source/remote_data_source/edit_profile_remote_data_source_contract.dart';
import 'package:flowery/features/edit_profile/data/models/request/edit_profile_request_model.dart';
import 'package:flowery/features/edit_profile/data/models/response/profile_response_model.dart';
import 'package:flowery/features/edit_profile/domain/entity/profile_entity.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repo_contract/edit_profile_repo_contract.dart';

@Injectable(as: EditProfileRepoContract)
class EditProfileRepoImpl implements EditProfileRepoContract {
  final EditProfileRemoteDataSourceContract _remoteDataSource;

  EditProfileRepoImpl(this._remoteDataSource);

  @override
  Future<Result<ProfileEntity>> getProfile() async {
    final result = await _remoteDataSource.getProfile();

    switch (result) {
      case Success<ProfileResponseModel>():
        return Success(data: result.data?.toDomain());

      case Error<ProfileResponseModel>():
        return Error(exception: result.exception);
    }
  }

  @override
  Future<Result<ProfileEntity>> editProfile(
    EditProfileRequestModel request,
  ) async {
    final result = await _remoteDataSource.editProfile(request);

    switch (result) {
      case Success<ProfileResponseModel>():
        return Success(data: result.data?.toDomain());

      case Error<ProfileResponseModel>():
        return Error(exception: result.exception);
    }
  }

  @override
  Future<Result<ProfileEntity>> uploadPhoto(File photo) async {
    final result = await _remoteDataSource.uploadPhoto(photo);

    switch (result) {
      case Success<ProfileResponseModel>():
        return Success(data: result.data?.toDomain());

      case Error<ProfileResponseModel>():
        return Error(exception: result.exception);
    }
  }
}
