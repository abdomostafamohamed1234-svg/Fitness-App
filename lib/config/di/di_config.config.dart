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
import '../../features/login/api/login_api_client.dart' as _i387;
import '../../features/login/data/data_source/remote_data_source/login_remote_data_source_contract.dart'
    as _i80;
import '../../features/login/data/data_source/remote_data_source/login_remote_data_source_impl.dart'
    as _i365;
import '../../features/login/data/repo/login_repo_impl.dart' as _i176;
import '../../features/login/domain/repo_contract/login_repo_contract.dart'
    as _i202;
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
    gh.factory<_i387.LoginApiClient>(
      () => _i387.LoginApiClient(gh<_i361.Dio>()),
    );
    gh.singleton<_i361.Dio>(
      () => diModule.mealsDio(),
      instanceName: 'mealsDio',
    );
    gh.factory<_i80.LoginRemoteDataSourceContract>(
      () => _i365.LoginRemoteDataSourceImpl(gh<_i387.LoginApiClient>()),
    );
    gh.factory<_i202.LoginRepoContract>(
      () => _i176.LoginRepoImpl(gh<_i80.LoginRemoteDataSourceContract>()),
    );
    return this;
  }
}

class _$DiModule extends _i211.DiModule {}
