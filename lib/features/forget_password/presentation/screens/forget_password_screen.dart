
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/base/base_state.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/features/forget_password/data/models/requestes/forget_password_request.dart';
import 'package:flowery/features/forget_password/presentation/screens/otp_screen.dart';
import 'package:flowery/features/forget_password/presentation/view_models/cubit/forget_password_view_model.dart';

import 'package:flowery/features/forget_password/presentation/view_models/events/forget_password_evente.dart';

import 'package:flowery/features/forget_password/presentation/view_models/states/forget_password_state.dart';
import 'package:flowery/features/forget_password/presentation/widgets/auth_background_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _submit(ForgetPasswordViewModel cubit) {
    if (_formKey.currentState?.validate() ?? false) {
      cubit.doIntent(
        event: SendEmailEvent(
          request: ForgetPasswordRequest(email: _emailController.text.trim()),
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
          prev.forgetPasswordState != curr.forgetPasswordState,
      listener: (context, state) {
        state.forgetPasswordState.when(
          initial: () {},
          loading: () {},
          success: (_) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    BlocProvider.value(value: cubit, child: const OtpScreen()),
              ),
            );
          },
          error: (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(e.toString())),
            );
          },
        );
      },
      child: AuthBackgroundScaffold(
        label: l10n.forget_password,
        children: [
          Text(
            l10n.enter_your_email,
            style: TextStyle(color: AppColors.whiteColor, fontSize: 13.sp),
          ),
          SizedBox(height: 4.h),
          Text(
            l10n.forget_password,
            style: TextStyle(
              color: AppColors.whiteColor,
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 24.h),
          Form(
            key: _formKey,
            child: TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              style:  TextStyle(color: AppColors.whiteColor),
              decoration:  InputDecoration(
                hintText: l10n.email,
                prefixIcon: Icon(Icons.email_outlined),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return l10n.please_enter_a_valid_email;
                }
                final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
                if (!emailRegex.hasMatch(value.trim())) {
                  return l10n.please_enter_a_valid_email;
                }
                return null;
              },
            ),
          ),
          SizedBox(height: 24.h),
          BlocBuilder<ForgetPasswordViewModel, ForgetPasswordState>(
            buildWhen: (prev, curr) =>
                prev.forgetPasswordState != curr.forgetPasswordState,
            builder: (context, state) {
              final isLoading =
                  state.forgetPasswordState.state == StateType.loading;
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
                      :  Text(l10n.sent_otp),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
