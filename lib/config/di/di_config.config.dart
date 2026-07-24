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
import '../../features/workouts/api/api_client/workouts_api_client.dart'
    as _i123;
import '../../features/workouts/api/datasources/workouts_remote_data_source_impl.dart'
    as _i355;
import '../../features/workouts/data/datasources/workouts_remote_data_source_contract.dart'
    as _i668;
import '../../features/workouts/data/repositories/workouts_repository_impl.dart'
    as _i774;
import '../../features/workouts/domain/repositories/workouts_repository.dart'
    as _i243;
import '../../features/workouts/domain/use_cases/get_muscles_group_by_id_use_case.dart'
    as _i350;
import '../../features/workouts/domain/use_cases/get_muscles_group_use_case.dart'
    as _i249;
import '../../features/workouts/presentation/view_model/cubit/workouts_cubit.dart'
    as _i152;
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
    gh.lazySingleton<_i123.WorkoutsApiClient>(
      () => _i123.WorkoutsApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i592.HomeApiClient>(() => _i592.HomeApiClient(gh<_i361.Dio>()));
    gh.factory<_i656.HomeRemoteDataSourceContract>(
      () => _i792.HomeRemoteDataSourceImpl(gh<_i592.HomeApiClient>()),
    );
    gh.factory<_i668.WorkoutRemoteDataSourceContract>(
      () => _i355.WorkoutsRemoteDataSourceImpl(gh<_i123.WorkoutsApiClient>()),
    );
    gh.factory<_i689.HomeRepositoryContract>(
      () => _i9.HomeRepositoryImpl(gh<_i656.HomeRemoteDataSourceContract>()),
    );
    gh.factory<_i497.HomeUseCase>(
      () => _i497.HomeUseCase(gh<_i689.HomeRepositoryContract>()),
    );
    gh.factory<_i243.WorkoutRepository>(
      () => _i774.WorkoutsRepositoryImpl(
        gh<_i668.WorkoutRemoteDataSourceContract>(),
      ),
    );
    gh.factory<_i350.GetMusclesGroupByIdUseCase>(
      () => _i350.GetMusclesGroupByIdUseCase(gh<_i243.WorkoutRepository>()),
    );
    gh.factory<_i249.GetMusclesGroupUseCase>(
      () => _i249.GetMusclesGroupUseCase(gh<_i243.WorkoutRepository>()),
    );
    gh.factory<_i940.HomeCubit>(() => _i940.HomeCubit(gh<_i497.HomeUseCase>()));
    gh.factory<_i152.WorkoutsCubit>(
      () => _i152.WorkoutsCubit(
        gh<_i249.GetMusclesGroupUseCase>(),
        gh<_i350.GetMusclesGroupByIdUseCase>(),
      ),
    );
    return this;
  }
}

class _$DiModule extends _i211.DiModule {}
