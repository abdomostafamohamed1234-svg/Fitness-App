import 'package:equatable/equatable.dart';
import 'package:flowery/features/auth_with_social_media/domain/entities/social_session_entity.dart';

sealed class SocialAuthResult extends Equatable {
  const SocialAuthResult();
}

class ExistingUserAuthResult extends SocialAuthResult {
  final LoginEntity login;

  const ExistingUserAuthResult(this.login);

  @override
  List<Object?> get props => [login];
}

class NewUserAuthResult extends SocialAuthResult {
  final SocialSessionEntity session;

  const NewUserAuthResult(this.session);

  @override
  List<Object?> get props => [session];
}
