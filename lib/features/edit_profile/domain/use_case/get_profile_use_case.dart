import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/edit_profile/domain/entity/profile_entity.dart';
import 'package:injectable/injectable.dart';

import '../repo_contract/edit_profile_repo_contract.dart';

@injectable
class GetProfileUseCase {
  final EditProfileRepoContract _editProfileRepo;

  GetProfileUseCase(this._editProfileRepo);

  Future<Result<ProfileEntity>> call() {
    return _editProfileRepo.getProfile();
  }
}
