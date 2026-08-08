import 'package:equatable/equatable.dart';

class RegisterEntity extends Equatable {
  final String? message;
  final String? error;

  const RegisterEntity({
    this.message,
    this.error,
  });

  @override
  List<Object?> get props => [message, error];
}