import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/edit_profile/data/models/request/edit_profile_request_model.dart';
import 'package:flowery/features/edit_profile/domain/entity/profile_entity.dart';
import 'package:injectable/injectable.dart';

import '../repo_contract/edit_profile_repo_contract.dart';

@injectable
class EditProfileUseCase {
  final EditProfileRepoContract _editProfileRepo;

  EditProfileUseCase(this._editProfileRepo);

  Future<Result<ProfileEntity>> call(EditProfileRequestModel request) {
    return _editProfileRepo.editProfile(request);
  }
}
