import 'package:flowery/core/base/base_state.dart';
import 'package:flowery/features/auth_with_social_media/domain/entities/social_auth_result.dart';

class SocialAuthState extends BaseState<SocialAuthResult> {
  const SocialAuthState.initial() : super.initial();

  const SocialAuthState.loading() : super.loading();

  const SocialAuthState.success(SocialAuthResult data) : super.success(data);

  const SocialAuthState.error(Exception? exception) : super.error(exception);
}
