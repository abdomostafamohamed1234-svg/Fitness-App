import 'package:equatable/equatable.dart';

abstract class SocialAuthEvent extends Equatable {
  const SocialAuthEvent();

  @override
  List<Object?> get props => [];
}

class GoogleSignInEvent extends SocialAuthEvent {
  const GoogleSignInEvent();
}

class FacebookSignInEvent extends SocialAuthEvent {
  const FacebookSignInEvent();
}

class SignOutEvent extends SocialAuthEvent {
  const SignOutEvent();
}
