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
import '../../features/register/api/api_client/register_api_client.dart'
    as _i656;
import '../../features/register/api/datasources/register_local_data_source_impl.dart'
    as _i240;
import '../../features/register/data/datasources/register_local_data_source_contract.dart'
    as _i1000;
import '../../features/register/data/repositories/register_repository_impl.dart'
    as _i68;
import '../../features/register/domain/repositories/register_repository.dart'
    as _i994;
import '../../features/register/domain/use_cases/register_usecase.dart'
    as _i679;
import '../../features/register/presentation/view_model/cubit/register_cubit.dart'
    as _i278;
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
    gh.factory<_i656.RegisterApiClient>(
      () => _i656.RegisterApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i1000.RegisterLocalDataSourceContract>(
      () => _i240.RegisterLocalDataSourceImpl(gh<_i656.RegisterApiClient>()),
    );
    gh.factory<_i994.RegisterRepository>(
      () => _i68.RegisterRepositoryImpl(
        gh<_i1000.RegisterLocalDataSourceContract>(),
      ),
    );
    gh.factory<_i679.RegisterUsecase>(
      () => _i679.RegisterUsecase(gh<_i994.RegisterRepository>()),
    );
    gh.factory<_i278.RegisterCubit>(
      () => _i278.RegisterCubit(gh<_i679.RegisterUsecase>()),
    );
    return this;
  }
}

class _$DiModule extends _i211.DiModule {}
