import 'dart:io';

import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/edit_profile/domain/entity/profile_entity.dart';
import 'package:injectable/injectable.dart';

import '../repo_contract/edit_profile_repo_contract.dart';

@injectable
class UploadPhotoUseCase {
  final EditProfileRepoContract _editProfileRepo;

  UploadPhotoUseCase(this._editProfileRepo);

  Future<Result<ProfileEntity>> call(File photo) {
    return _editProfileRepo.uploadPhoto(photo);
  }
}
