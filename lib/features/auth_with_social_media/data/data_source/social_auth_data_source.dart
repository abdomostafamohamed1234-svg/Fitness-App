import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/auth_with_social_media/data/models/social_user_model.dart';

abstract interface class SocialAuthDataSourceContract {
  Future<Result<SocialUserModel>> signInWithGoogle();

  Future<Result<SocialUserModel>> signInWithFacebook();

  Future<void> signOut();
}