import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/base/base_state.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/features/forget_password/data/models/requestes/forget_password_request.dart';
import 'package:flowery/features/forget_password/data/models/requestes/verify_reset_password_request.dart';
import 'package:flowery/features/forget_password/presentation/screens/create_password_screen.dart';
import 'package:flowery/features/forget_password/presentation/view_models/cubit/forget_password_view_model.dart';
import 'package:flowery/features/forget_password/presentation/view_models/events/forget_password_evente.dart';
import 'package:flowery/features/forget_password/presentation/view_models/states/forget_password_state.dart';
import 'package:flowery/features/forget_password/presentation/widgets/auth_background_scaffold.dart';
import 'package:flowery/features/forget_password/presentation/widgets/otp_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cubit = context.read<ForgetPasswordViewModel>();

    return BlocListener<ForgetPasswordViewModel, ForgetPasswordState>(
      listenWhen: (prev, curr) =>
          prev.verifyEmailState != curr.verifyEmailState,
      listener: (context, state) {
        state.verifyEmailState.when(
          initial: () {},
          loading: () {},
          success: (_) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: cubit,
                  child: const CreatePasswordScreen(),
                ),
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
        label: l10n.otp,
        children: [
          Text(
            l10n.otp_code,
            style: TextStyle(
              color: AppColors.whiteColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
           l10n.enter_your_otp_check_your_email,
            style: TextStyle(color: AppColors.whiteColor, fontSize: 13.sp),
          ),
          SizedBox(height: 24.h),
          BlocBuilder<ForgetPasswordViewModel, ForgetPasswordState>(
            buildWhen: (prev, curr) => prev.otpResetKey != curr.otpResetKey,
            builder: (context, state) {
              return OtpInputWidget(
                resetKey: state.otpResetKey,
                onChanged: (otp) {
                  cubit.doIntent(event: UpdateOtpEvent(otp: otp));
                },
              );
            },
          ),
          BlocBuilder<ForgetPasswordViewModel, ForgetPasswordState>(
            buildWhen: (prev, curr) => prev.hasError != curr.hasError,
            builder: (context, state) {
              if (!state.hasError) return SizedBox(height: 12.h);
              return Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: Text(
                  l10n.invalid_code_please_try_again,
                  style: TextStyle(
                    color: AppColors.errorColor,
                    fontSize: 12.sp,
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 12.h),
          BlocBuilder<ForgetPasswordViewModel, ForgetPasswordState>(
            buildWhen: (prev, curr) =>
                prev.verifyEmailState != curr.verifyEmailState ||
                prev.otpValue != curr.otpValue,
            builder: (context, state) {
              final isLoading =
                  state.verifyEmailState.state == StateType.loading;
              final isComplete = state.otpValue.length == 6;
              return SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (isLoading || !isComplete)
                      ? null
                      : () => cubit.doIntent(
                          event: VerifyEmailEvent(
                            request: VerifyResetPasswordRequest(
                              resetCode: state.otpValue,
                            ),
                          ),
                        ),
                  child: isLoading
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.4,
                            color: AppColors.whiteColor,
                          ),
                        )
                      :  Text(l10n.confirm),
                ),
              );
            },
          ),
          SizedBox(height: 16.h),
          Text(
            l10n.did_not_receive_verification_code,
            style: TextStyle(color: AppColors.lightGreyColor, fontSize: 12.sp),
          ),
          SizedBox(height: 4.h),
          BlocBuilder<ForgetPasswordViewModel, ForgetPasswordState>(
            buildWhen: (prev, curr) =>
                prev.isResendEnabled != curr.isResendEnabled ||
                prev.timerValue != curr.timerValue ||
                prev.email != curr.email,
            builder: (context, state) {
              return TextButton(
                onPressed: state.isResendEnabled
                    ? () {
                        if (state.email != null) {
                          cubit.doIntent(
                            event: SendEmailEvent(
                              request: ForgetPasswordRequest(
                                email: state.email,
                              ),
                            ),
                          );
                        }
                      }
                    : null,
                child: Text(
                  state.isResendEnabled
                      ? l10n.resend_code
                      : 'Resend Code in ${state.timerValue}s',
                  style: TextStyle(
                    color: state.isResendEnabled
                        ? AppColors.primaryColor
                        :AppColors.borderColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 13.sp,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
