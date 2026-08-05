
import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/forget_password/data/models/requestes/forget_password_request.dart';
import 'package:flowery/features/forget_password/data/models/responses/forget_password_response.dart';
import 'package:flowery/features/forget_password/domain/repo/forget_password_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class ForgetPasswordUseCase {
  ForgetPasswordRepoContract repo;

  ForgetPasswordUseCase(this.repo);

  Future<Result<ForgetPasswordResponse>> forgetPassword(
      ForgetPasswordRequest request,
      ) {
    return repo.forgetPassword(request);
  }
}


