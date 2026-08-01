import 'dart:io';

import 'package:flowery/features/edit_profile/data/models/request/edit_profile_request_model.dart';
import 'package:flowery/features/edit_profile/data/models/response/profile_response_model.dart';

import '../../../../../core/base/base_response.dart';

abstract class EditProfileRemoteDataSourceContract {
  Future<Result<ProfileResponseModel>> getProfile();

  Future<Result<ProfileResponseModel>> editProfile(EditProfileRequestModel request);

  Future<Result<ProfileResponseModel>> uploadPhoto(File photo);
}
