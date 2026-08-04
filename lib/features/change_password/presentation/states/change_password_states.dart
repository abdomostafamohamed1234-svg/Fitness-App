import 'package:equatable/equatable.dart';

class ChangePasswordState extends Equatable {
  final bool isLoading;
  final bool isDone;
  final String? message;
  final bool isOldPasswordVisible;
  final bool isNewPasswordVisible;
  final bool isConfirmPasswordVisible;

  const ChangePasswordState({
    this.isLoading = false,
    this.message,
    this.isDone = false,
    this.isOldPasswordVisible = false,
    this.isNewPasswordVisible = false,
    this.isConfirmPasswordVisible = false,
  });

  ChangePasswordState copyWith({
    final bool? isLoading,
    final bool? isDone,
    final String? message,
    final bool? isOldPasswordVisible,
    final bool? isNewPasswordVisible,
    final bool? isConfirmPasswordVisible,
  }) => ChangePasswordState(
    isLoading: isLoading ?? this.isLoading,
    isDone: isDone ?? this.isDone,
    message: message ?? this.message,
    isOldPasswordVisible: isOldPasswordVisible ?? this.isOldPasswordVisible,
    isNewPasswordVisible: isNewPasswordVisible ?? this.isNewPasswordVisible,
    isConfirmPasswordVisible:
        isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
  );

  @override
  List<Object?> get props => [
    isLoading,
    message,
    isDone,
    isOldPasswordVisible,
    isNewPasswordVisible,
    isConfirmPasswordVisible,
  ];
}