import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/forget_password/data/data_source/forget_password_data_source_contract.dart';
import 'package:flowery/features/forget_password/data/models/requestes/forget_password_request.dart';
import 'package:flowery/features/forget_password/data/models/requestes/reset_password_request.dart';
import 'package:flowery/features/forget_password/data/models/requestes/verify_reset_password_request.dart';
import 'package:flowery/features/forget_password/data/models/responses/forget_password_response.dart';
import 'package:flowery/features/forget_password/data/models/responses/reset_password_response.dart';
import 'package:flowery/features/forget_password/data/models/responses/verify_email_response.dart';
import 'package:flowery/features/forget_password/domain/repo/forget_password_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ForgetPasswordRepoContract)
class ForgetPasswordRepoImp implements ForgetPasswordRepoContract {
  final ForgetPasswordDataSourceContract remoteDataSource;
  ForgetPasswordRepoImp(this.remoteDataSource);


  
   @override
  Future<Result<ForgetPasswordResponse>> forgetPassword(
      ForgetPasswordRequest request,
      ) {
    return remoteDataSource.forgetPassword(request);
  }

  @override
  Future<Result<VerifyEmailResponse>> verifyEmail(VerifyResetPasswordRequest request) async {
    return await remoteDataSource.verifyEmail(request);

  }


  @override
  Future<Result<ResetPasswordResponse>> resetPassword(
      ResetPasswordRequest request,
      ) async {
    return  await remoteDataSource.resetPassword(request);

  }

}
