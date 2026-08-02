
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/base/base_state.dart';
import 'package:flowery/core/theme/app_colors.dart';

import 'package:flowery/features/forget_password/data/models/requestes/reset_password_request.dart';
import 'package:flowery/features/forget_password/presentation/view_models/cubit/forget_password_view_model.dart';
import 'package:flowery/features/forget_password/presentation/view_models/events/forget_password_evente.dart';

import 'package:flowery/features/forget_password/presentation/view_models/states/forget_password_state.dart';
import 'package:flowery/features/forget_password/presentation/widgets/auth_background_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({super.key});

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submit(ForgetPasswordViewModel cubit) {
    if (_formKey.currentState?.validate() ?? false) {
      cubit.doIntent(
        event: ResetPasswordEvent(
          request: ResetPasswordRequest(password: _passwordController.text),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cubit = context.read<ForgetPasswordViewModel>();

    return BlocListener<ForgetPasswordViewModel, ForgetPasswordState>(
      listenWhen: (prev, curr) =>
          prev.resetPasswordState != curr.resetPasswordState,
      listener: (context, state) {
        state.resetPasswordState.when(
          initial: () {},
          loading: () {},
          success: (_) {
            // Password reset done — send the user back to login (first route).
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
          error: (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(e.toString())),
            );
          },
        );
      },
      child: AuthBackgroundScaffold(
        label: 'create pass',
        children: [
          Text(
            l10n.make_sure_its_8_character_or_more,
            style: TextStyle(color:AppColors.whiteColor, fontSize: 13.sp),
          ),
          SizedBox(height: 4.h),
          Text(
            l10n.create_new_password,
            style: TextStyle(
              color: AppColors.whiteColor,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 24.h),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  style: const TextStyle(color:AppColors.whiteColor),
                  decoration: InputDecoration(
                    hintText: l10n.password,
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                      onPressed: () => setState(
                        () => _obscurePassword = !_obscurePassword,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.length < 8) {
                      return l10n.password_must_be_8_character_or_more;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: _obscureConfirmPassword,
                  style:  const TextStyle(color: AppColors.whiteColor),
                  decoration: InputDecoration(
                    hintText: l10n.password,
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                      onPressed: () => setState(
                        () => _obscureConfirmPassword =
                            !_obscureConfirmPassword,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value != _passwordController.text) {
                      return l10n.password_do_not_match;
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
          BlocBuilder<ForgetPasswordViewModel, ForgetPasswordState>(
            buildWhen: (prev, curr) =>
                prev.resetPasswordState != curr.resetPasswordState,
            builder: (context, state) {
              final isLoading =
                  state.resetPasswordState.state == StateType.loading;
              return SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading ? null : () => _submit(cubit),
                  child: isLoading
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.4,
                            color: AppColors.whiteColor,
                          ),
                        )
                      :  Text(l10n.done),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
