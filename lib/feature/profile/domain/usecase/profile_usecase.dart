import 'package:flowery/feature/profile/domain/entities/profile_entity.dart';
import 'package:flowery/feature/profile/domain/repository/profile_%20repository_contract.dart';
import 'package:injectable/injectable.dart';
import 'package:flowery/core/base/base_response.dart';


@injectable
class ProfileUseCase {
  ProfileUseCase(this._profileRepository);

  final ProfileRepository _profileRepository;

  Future<Result<ProfileEntity>> callProfileData() {
    return _profileRepository.getProfile();
  }
}