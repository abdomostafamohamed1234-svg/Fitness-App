
import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/forget_password/data/models/requestes/reset_password_request.dart';
import 'package:flowery/features/forget_password/data/models/responses/reset_password_response.dart';
import 'package:flowery/features/forget_password/domain/repo/forget_password_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class ResetPasswordUseCase {
  ForgetPasswordRepoContract repo;

  ResetPasswordUseCase(this.repo);

  Future<Result<ResetPasswordResponse>> resetPassword(
      ResetPasswordRequest request,
      ) {
    return repo.resetPassword(request);
  }
}