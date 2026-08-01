import 'dart:io';

import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/edit_profile/data/models/request/edit_profile_request_model.dart';
import 'package:flowery/features/edit_profile/domain/entity/profile_entity.dart';

abstract class EditProfileRepoContract {
  Future<Result<ProfileEntity>> getProfile();

  Future<Result<ProfileEntity>> editProfile(EditProfileRequestModel request);

  Future<Result<ProfileEntity>> uploadPhoto(File photo);
}
