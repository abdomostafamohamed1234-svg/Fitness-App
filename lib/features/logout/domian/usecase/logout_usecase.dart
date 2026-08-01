import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/logout/domian/repository/logout_repository_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class LogoutUseCase {
  LogoutUseCase(this._logoutRepository);

  final LogoutRepository _logoutRepository;

  Future<Result<void>> call() {
    return _logoutRepository.logout();
  }
}