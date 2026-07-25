import 'package:equatable/equatable.dart';

import 'social_user_entity.dart';

class SocialSessionEntity extends Equatable {
  final SocialUserEntity user;
  final String generatedPassword;

  const SocialSessionEntity({
    required this.user,
    required this.generatedPassword,
  });

  @override
  List<Object?> get props => [user, generatedPassword];
}
