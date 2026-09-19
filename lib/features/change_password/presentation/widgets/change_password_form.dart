import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/widgets/glass_container.dart';
import 'package:flowery/features/change_password/presentation/events/change_password_events.dart';
import 'package:flowery/features/change_password/presentation/states/change_password_states.dart';
import 'package:flowery/features/change_password/presentation/view_model/change_password_view_model.dart';
import 'package:flowery/features/change_password/presentation/widgets/password_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'done_button.dart';

class ChangePasswordForm extends StatefulWidget {
  const ChangePasswordForm({super.key});

  @override
  State<ChangePasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ChangePasswordForm> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
       final localizations = AppLocalizations.of(context)!;
    return BlocBuilder<ChangePasswordViewModel, ChangePasswordState>(
      builder: (context, state) {
        final cubit = context.read<ChangePasswordViewModel>();

        return GlassContainer(
          children: [
            PasswordTextField(
              controller: _oldPasswordController,
              hintText: localizations.old_password,
              obscureText: !state.isOldPasswordVisible,
              onToggleVisibility: () =>
                  cubit.doEvent(ToggleOldPasswordVisibility()),
            ),
            const SizedBox(height: 16),
            PasswordTextField(
              controller: _newPasswordController,
              hintText: localizations.new_password,
              obscureText: !state.isNewPasswordVisible,
              onToggleVisibility: () =>
                  cubit.doEvent(ToggleNewPasswordVisibility()),
            ),
            const SizedBox(height: 16),
            PasswordTextField(
              controller: _confirmPasswordController,
              hintText: localizations.confirm_password,
              obscureText: !state.isConfirmPasswordVisible,
              onToggleVisibility: () =>
                  cubit.doEvent(ToggleConfirmPasswordVisibility()),
            ),
            const SizedBox(height: 28),
            DoneButton(
              isLoading: state.isLoading,
              onPressed: () {
                cubit.doEvent(
                  UpdatePasswordEvent(
                    password: _oldPasswordController.text,
                    newPassword: _newPasswordController.text,
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}