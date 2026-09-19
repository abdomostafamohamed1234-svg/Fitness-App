import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/forget_password/data/models/requestes/forget_password_request.dart';
import 'package:flowery/features/forget_password/data/models/requestes/reset_password_request.dart';
import 'package:flowery/features/forget_password/data/models/requestes/verify_reset_password_request.dart';
import 'package:flowery/features/forget_password/data/models/responses/forget_password_response.dart';
import 'package:flowery/features/forget_password/data/models/responses/reset_password_response.dart';
import 'package:flowery/features/forget_password/data/models/responses/verify_email_response.dart';

abstract class ForgetPasswordDataSourceContract {
    Future<Result<ForgetPasswordResponse>> forgetPassword(ForgetPasswordRequest request,);

  Future<Result<VerifyEmailResponse>> verifyEmail(VerifyResetPasswordRequest request);

  Future<Result<ResetPasswordResponse>> resetPassword(
      ResetPasswordRequest request,
      );
}