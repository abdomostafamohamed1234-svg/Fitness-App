import 'package:equatable/equatable.dart';

class ChangePasswordResponseEntity extends Equatable {
  final String message;

  const ChangePasswordResponseEntity({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}