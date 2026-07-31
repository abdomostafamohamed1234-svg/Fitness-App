import 'package:flowery/core/utils/social_password_generator.dart';
import 'package:flowery/features/auth_with_social_media/domain/entities/social_session_entity.dart';
import 'package:flowery/features/auth_with_social_media/domain/entities/social_user_entity.dart';
import 'package:injectable/injectable.dart';

@injectable
class CreateSocialSessionUseCase {
  final SocialPasswordGenerator passwordGenerator;

  CreateSocialSessionUseCase(this.passwordGenerator);

  SocialSessionEntity invoke(SocialUserEntity user) {
    return SocialSessionEntity(
      user: user,
      generatedPassword: passwordGenerator.generate(user.uid),
    );
  }
}
