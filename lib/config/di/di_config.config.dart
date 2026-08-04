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
import '../../feature/logout/api/api_client/logout_api_client.dart' as _i773;
import '../../feature/logout/data/repository/logout_repository_impl.dart'
    as _i228;
import '../../feature/logout/domian/repository/logout_repository_contract.dart'
    as _i425;
import '../../feature/logout/domian/usecase/logout_usecase.dart' as _i340;
import '../../feature/logout/presentation/veiw_model.dart/logout_cubit.dart'
    as _i83;
import '../../feature/profile/api/api/profile_api_client.dart' as _i242;
import '../../feature/profile/api/datasourse/local_datasourse_impl.dart'
    as _i138;
import '../../feature/profile/data/repository/profile_repository_impl.dart'
    as _i681;
import '../../feature/profile/domain/repository/profile_%20repository_contract.dart'
    as _i740;
import '../../feature/profile/domain/usecase/profile_usecase.dart' as _i766;
import '../../feature/profile/presentation/view_model/profile_cubit.dart'
    as _i386;
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
    gh.factory<_i773.LogoutApiClient>(
      () => _i773.LogoutApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i242.ProfileApiClient>(
      () => _i242.ProfileApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i740.ProfileRepository>(
      () => _i681.ProfileRepositoryImpl(gh<_i242.ProfileApiClient>()),
    );
    gh.lazySingleton<_i138.TokenLocalDataSource>(
      () => _i138.TokenLocalDataSource(gh<_i558.FlutterSecureStorage>()),
    );
    gh.factory<_i766.ProfileUseCase>(
      () => _i766.ProfileUseCase(gh<_i740.ProfileRepository>()),
    );
    gh.factory<_i425.LogoutRepository>(
      () => _i228.LogoutRepositoryImpl(
        gh<_i773.LogoutApiClient>(),
        gh<_i558.FlutterSecureStorage>(),
      ),
    );
    gh.factory<_i386.ProfileCubit>(
      () => _i386.ProfileCubit(gh<_i766.ProfileUseCase>()),
    );
    gh.factory<_i340.LogoutUseCase>(
      () => _i340.LogoutUseCase(gh<_i425.LogoutRepository>()),
    );
    gh.factory<_i83.LogoutCubit>(
      () => _i83.LogoutCubit(gh<_i340.LogoutUseCase>()),
    );
    return this;
  }
}

class _$DiModule extends _i211.DiModule {}
