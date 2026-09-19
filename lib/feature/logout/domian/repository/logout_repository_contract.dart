import 'package:flowery/core/base/base_response.dart';

abstract class LogoutRepository {
  Future<Result<void>> logout();
}
