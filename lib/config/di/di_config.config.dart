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
import '../../features/home/api/api_client/home_api_client.dart' as _i592;
import '../../features/home/api/datasourse/home_remote_datasourse_impl.dart'
    as _i792;
import '../../features/home/data/datasourse/home_remote_datasourse_impl.dart'
    as _i656;
import '../../features/home/data/repository/home_repository_impl.dart' as _i9;
import '../../features/home/domian/repository/home_repository_contract.dart'
    as _i689;
import '../../features/home/domian/use_case/use_case.dart' as _i497;
import '../../features/home/presentation/view_model/home_cubit.dart' as _i940;
import '../../features/popular_training/api/api_client/popular_training_api_client.dart'
    as _i763;
import '../../features/popular_training/api/datasource/popular_training_datasource_impl.dart'
    as _i439;
import '../../features/popular_training/data/repository/popular_training_repository_impl.dart'
    as _i234;
import '../../features/popular_training/domain/repository/popular_training_repository_contract.dart'
    as _i539;
import '../../features/popular_training/domain/usecase/get_exercises_usecase.dart'
    as _i1048;
import '../../features/popular_training/presentation/view_model/popular_training_cubit.dart'
    as _i695;
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
    gh.factory<_i592.HomeApiClient>(() => _i592.HomeApiClient(gh<_i361.Dio>()));
    gh.factory<_i763.PopularTrainingApiClient>(
      () => _i763.PopularTrainingApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i439.PopularTrainingRemoteDataSource>(
      () => _i439.PopularTrainingRemoteDataSourceImpl(
        gh<_i763.PopularTrainingApiClient>(),
      ),
    );
    gh.factory<_i539.PopularTrainingRepository>(
      () => _i234.PopularTrainingRepositoryImpl(
        gh<_i439.PopularTrainingRemoteDataSource>(),
      ),
    );
    gh.factory<_i1048.GetPopularTrainingUseCase>(
      () => _i1048.GetPopularTrainingUseCase(
        gh<_i539.PopularTrainingRepository>(),
      ),
    );
    gh.factory<_i656.HomeRemoteDataSourceContract>(
      () => _i792.HomeRemoteDataSourceImpl(gh<_i592.HomeApiClient>()),
    );
    gh.factory<_i695.PopularTrainingCubit>(
      () => _i695.PopularTrainingCubit(gh<_i1048.GetPopularTrainingUseCase>()),
    );
    gh.factory<_i689.HomeRepositoryContract>(
      () => _i9.HomeRepositoryImpl(gh<_i656.HomeRemoteDataSourceContract>()),
    );
    gh.factory<_i497.HomeUseCase>(
      () => _i497.HomeUseCase(gh<_i689.HomeRepositoryContract>()),
    );
    gh.factory<_i940.HomeCubit>(() => _i940.HomeCubit(gh<_i497.HomeUseCase>()));
    return this;
  }
}

class _$DiModule extends _i211.DiModule {}
