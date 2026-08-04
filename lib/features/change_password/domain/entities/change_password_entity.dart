import 'package:equatable/equatable.dart';

class ChangePasswordEntity extends Equatable {
  final String password;
  final String newPassword;

  const ChangePasswordEntity({
    required this.password,
    required this.newPassword,
  });

  @override
  List<Object?> get props => [
        password,
        newPassword,
      ];
}