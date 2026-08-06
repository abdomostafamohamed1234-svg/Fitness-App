import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/forget_password/api/api_client/forget_password_api_client.dart';
import 'package:flowery/features/forget_password/data/data_source/forget_password_data_source_contract.dart';
import 'package:flowery/features/forget_password/data/models/requestes/forget_password_request.dart';
import 'package:flowery/features/forget_password/data/models/requestes/reset_password_request.dart';
import 'package:flowery/features/forget_password/data/models/requestes/verify_reset_password_request.dart';
import 'package:flowery/features/forget_password/data/models/responses/forget_password_response.dart';
import 'package:flowery/features/forget_password/data/models/responses/reset_password_response.dart';
import 'package:flowery/features/forget_password/data/models/responses/verify_email_response.dart';
import 'package:injectable/injectable.dart';
const bool isMock = true;
@Injectable(as: ForgetPasswordDataSourceContract)
class ForgetPasswordDataSourceImp implements ForgetPasswordDataSourceContract {
  final ForgetPasswordApiClient apiClient;
  ForgetPasswordDataSourceImp(this.apiClient);


  @override
  Future<Result<ForgetPasswordResponse>> forgetPassword(
    ForgetPasswordRequest request,
  ) async {
    if (isMock) {
      await Future.delayed(const Duration(seconds: 2));

      return Success(data: ForgetPasswordResponse());
    }
final response = await apiClient.forgetPassword(request);
  return Success(data: response);
  }

  @override
  Future<Result<VerifyEmailResponse>> verifyEmail(
    VerifyResetPasswordRequest request,
  ) async {
    // ================= MOCK =================
    if (isMock) {
      await Future.delayed(const Duration(seconds: 2));

      return Success(data: VerifyEmailResponse());
    }

    final response = await apiClient.verifyEmail(request);
  return Success(data: response);

  }

  @override
  Future<Result<ResetPasswordResponse>> resetPassword(
    ResetPasswordRequest request,
  ) async {
    // ================= MOCK =================
    if (isMock) {
      await Future.delayed(const Duration(seconds: 2));

      return Success(data: ResetPasswordResponse());
    }

final response = await apiClient.resetPassword(request);
  return Success(data: response);

  }
}
