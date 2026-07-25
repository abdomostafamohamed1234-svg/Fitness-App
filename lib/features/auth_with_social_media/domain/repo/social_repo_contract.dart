import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/auth_with_social_media/domain/entities/social_user_entity.dart';

abstract interface class SocialAuthRepoContract {
  Future<Result<SocialUserEntity>> signInWithGoogle();

  Future<Result<SocialUserEntity>> signInWithFacebook();

  Future<void> signOut();
}