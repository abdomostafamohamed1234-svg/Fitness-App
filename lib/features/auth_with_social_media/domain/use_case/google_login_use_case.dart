import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/auth_with_social_media/domain/entities/social_user_entity.dart';
import 'package:flowery/features/auth_with_social_media/domain/repo/social_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GoogleSignInUseCase {
  final SocialAuthRepoContract repo;

  GoogleSignInUseCase(this.repo);

  Future<Result<SocialUserEntity>> invoke() {
    return repo.signInWithGoogle();
  }
}