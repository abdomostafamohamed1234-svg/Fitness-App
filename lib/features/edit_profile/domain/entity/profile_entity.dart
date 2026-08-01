import 'package:equatable/equatable.dart';

import 'user_entity.dart';

class ProfileEntity extends Equatable {
  final String message;
  final UserEntity? user;

  const ProfileEntity({
    required this.message,
    this.user,
  });

  @override
  List<Object?> get props => [message, user];
}
