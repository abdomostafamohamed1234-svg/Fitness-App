import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/auth_with_social_media/data/data_source/social_auth_data_source.dart';
import 'package:flowery/features/auth_with_social_media/data/mappers/social_user_mapper.dart';
import 'package:flowery/features/auth_with_social_media/data/models/social_user_model.dart';
import 'package:flowery/features/auth_with_social_media/domain/entities/social_user_entity.dart';
import 'package:flowery/features/auth_with_social_media/domain/repo/social_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SocialAuthRepoContract)
class SocialAuthRepoImpl implements SocialAuthRepoContract {
  final SocialAuthDataSourceContract dataSource;

  SocialAuthRepoImpl(this.dataSource);

  @override
  Future<Result<SocialUserEntity>> signInWithGoogle() async {
    final response = await dataSource.signInWithGoogle();

    switch (response) {
      case Success<SocialUserModel>():
        return Success(data: response.data?.toDomain());

      case Error<SocialUserModel>():
        return Error(exception: response.exception);
    }
  }

  @override
  Future<Result<SocialUserEntity>> signInWithFacebook() async {
    final response = await dataSource.signInWithFacebook();

    switch (response) {
      case Success<SocialUserModel>():
        return Success(data: response.data?.toDomain());

      case Error<SocialUserModel>():
        return Error(exception: response.exception);
    }
  }

  @override
  Future<void> signOut() {
    return dataSource.signOut();
  }
}
