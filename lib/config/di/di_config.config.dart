// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../core/cubits/locale/locale_cubit.dart' as _i273;
import '../../features/edit_profile/api/edit_profile_api_client.dart' as _i935;
import '../../features/edit_profile/data/data_source/remote_data_source/edit_profile_remote_data_source_contract.dart'
    as _i786;
import '../../features/edit_profile/data/data_source/remote_data_source/edit_profile_remote_data_source_impl.dart'
    as _i131;
import '../../features/edit_profile/data/repo/edit_profile_repo_impl.dart'
    as _i440;
import '../../features/edit_profile/domain/repo_contract/edit_profile_repo_contract.dart'
    as _i977;
import '../../features/edit_profile/domain/use_case/edit_profile_use_case.dart'
    as _i226;
import '../../features/edit_profile/domain/use_case/get_profile_use_case.dart'
    as _i501;
import '../../features/edit_profile/domain/use_case/upload_photo_use_case.dart'
    as _i776;
import '../../features/edit_profile/presentation/view_model/cubit.dart' as _i36;
import '../helpers/shared_preferences/shared_preferences_helper.dart' as _i425;
import 'di_module.dart' as _i211;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final diModule = _$DiModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => diModule.sharedPreferences(),
      preResolve: true,
    );
    gh.singleton<_i361.Dio>(() => diModule.dio());
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => diModule.secureStorage(),
    );
    gh.factory<_i425.SharedPreferencesHelper>(
      () => _i425.SharedPreferencesHelper(gh<_i460.SharedPreferences>()),
    );
    gh.factory<_i273.LocaleCubit>(
      () => _i273.LocaleCubit(gh<_i425.SharedPreferencesHelper>()),
    );
    gh.factory<_i935.EditProfileApiClient>(
      () => _i935.EditProfileApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i786.EditProfileRemoteDataSourceContract>(
      () => _i131.EditProfileRemoteDataSourceImpl(
        gh<_i935.EditProfileApiClient>(),
      ),
    );
    gh.singleton<_i361.Dio>(
      () => diModule.mealsDio(),
      instanceName: 'mealsDio',
    );
    gh.factory<_i977.EditProfileRepoContract>(
      () => _i440.EditProfileRepoImpl(
        gh<_i786.EditProfileRemoteDataSourceContract>(),
      ),
    );
    gh.factory<_i226.EditProfileUseCase>(
      () => _i226.EditProfileUseCase(gh<_i977.EditProfileRepoContract>()),
    );
    gh.factory<_i501.GetProfileUseCase>(
      () => _i501.GetProfileUseCase(gh<_i977.EditProfileRepoContract>()),
    );
    gh.factory<_i776.UploadPhotoUseCase>(
      () => _i776.UploadPhotoUseCase(gh<_i977.EditProfileRepoContract>()),
    );
    gh.factory<_i36.EditProfileCubit>(
      () => _i36.EditProfileCubit(
        gh<_i501.GetProfileUseCase>(),
        gh<_i226.EditProfileUseCase>(),
        gh<_i776.UploadPhotoUseCase>(),
      ),
    );
    return this;
  }
}

class _$DiModule extends _i211.DiModule {}
