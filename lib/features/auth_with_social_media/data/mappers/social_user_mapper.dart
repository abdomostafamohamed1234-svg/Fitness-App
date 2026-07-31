import 'package:flowery/features/auth_with_social_media/data/models/social_user_model.dart';
import 'package:flowery/features/auth_with_social_media/domain/entities/social_user_entity.dart';

extension SocialUserMapper on SocialUserModel {
  SocialUserEntity toDomain() {
    return SocialUserEntity(
      uid: uid,
      email: email,
      firstName: firstName,
      lastName: lastName,
      photoUrl: photoUrl,
      provider: provider,
      providerToken: providerToken,
    );
  }
}