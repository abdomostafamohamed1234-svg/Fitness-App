
import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/forget_password/data/models/requestes/verify_reset_password_request.dart';
import 'package:flowery/features/forget_password/data/models/responses/verify_email_response.dart';
import 'package:flowery/features/forget_password/domain/repo/forget_password_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class VerifyEmailUseCase {
  ForgetPasswordRepoContract repo;

  VerifyEmailUseCase(this.repo);

  Future<Result<VerifyEmailResponse>> verifyEmail(
      VerifyResetPasswordRequest request,
      ) {
    return repo.verifyEmail(request);
  }
}