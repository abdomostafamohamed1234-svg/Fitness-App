sealed class ChangePasswordEvents {}
class ToggleOldPasswordVisibility extends ChangePasswordEvents {}
class ToggleNewPasswordVisibility extends ChangePasswordEvents {}
class ToggleConfirmPasswordVisibility extends ChangePasswordEvents {}
class UpdatePasswordEvent extends ChangePasswordEvents {
  final String password;
  final String newPassword;

  UpdatePasswordEvent({required this.password, required this.newPassword});
}