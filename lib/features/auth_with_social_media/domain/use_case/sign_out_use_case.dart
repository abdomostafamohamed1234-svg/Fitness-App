import 'package:flowery/features/auth_with_social_media/domain/repo/social_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignOutUseCase {
  final SocialAuthRepoContract repo;

  SignOutUseCase(this.repo);

  Future<void> invoke() {
    return repo.signOut();
  }
}