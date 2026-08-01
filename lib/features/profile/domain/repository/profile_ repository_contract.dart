import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/profile/domain/entities/profile_entity.dart';

abstract class ProfileRepository {
  Future<Result<ProfileEntity>> getProfile();
}
