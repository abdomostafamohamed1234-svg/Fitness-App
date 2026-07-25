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
import '../../features/food/api/api_client/food_api_client.dart' as _i310;
import '../../features/food/api/data_sources/food_remote_data_source_impl.dart'
    as _i58;
import '../../features/food/data/data_sources/food_remote_data_source_contract.dart'
    as _i656;
import '../../features/food/data/repo/food_repo_impl.dart' as _i20;
import '../../features/food/domain/repo/food_repo_contract.dart' as _i901;
import '../../features/food/domain/use_cases/get_meal_details_use_case.dart'
    as _i687;
import '../../features/food/domain/use_cases/get_meals_categories_use_case.dart'
    as _i282;
import '../../features/food/domain/use_cases/select_meals_category_use_case.dart'
    as _i904;
import '../../features/food/presentation/view_model/cubit/food_cubit.dart'
    as _i660;
import '../../features/login/api/login_api_client.dart' as _i387;
import '../../features/login/data/data_source/remote_data_source/login_remote_data_source_contract.dart'
    as _i80;
import '../../features/login/data/data_source/remote_data_source/login_remote_data_source_impl.dart'
    as _i365;
import '../../features/login/data/repo/login_repo_impl.dart' as _i176;
import '../../features/login/domain/repo_contract/login_repo_contract.dart'
    as _i202;
import '../../features/login/domain/use_case/login_use_case.dart' as _i168;
import '../../features/login/presentation/view_model/cubit.dart' as _i272;
import '../../features/on_boarding/presentation/view_model/cubit/on_boarding_cubit.dart'
    as _i786;
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
    gh.factory<_i786.OnBoardingCubit>(() => _i786.OnBoardingCubit());
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
    gh.factory<_i310.FoodApiClient>(
      () => _i310.FoodApiClient(gh<_i361.Dio>(instanceName: 'mealsDio')),
    );
    gh.factory<_i202.LoginRepoContract>(
      () => _i176.LoginRepoImpl(gh<_i80.LoginRemoteDataSourceContract>()),
    );
    gh.factory<_i168.LoginUseCase>(
      () => _i168.LoginUseCase(gh<_i202.LoginRepoContract>()),
    );
    gh.factory<_i656.FoodRemoteDataSourceContract>(
      () => _i58.FoodRemoteDataSourceImpl(gh<_i310.FoodApiClient>()),
    );
    gh.factory<_i901.FoodRepoContract>(
      () => _i20.FoodRepoImpl(gh<_i656.FoodRemoteDataSourceContract>()),
    );
    gh.factory<_i272.LoginCubit>(
      () => _i272.LoginCubit(gh<_i168.LoginUseCase>()),
    );
    gh.factory<_i687.GetMealDetailsUseCase>(
      () => _i687.GetMealDetailsUseCase(gh<_i901.FoodRepoContract>()),
    );
    gh.factory<_i282.GetMealsCategoriesUseCase>(
      () => _i282.GetMealsCategoriesUseCase(gh<_i901.FoodRepoContract>()),
    );
    gh.factory<_i904.SelectMealsCategoryUseCase>(
      () => _i904.SelectMealsCategoryUseCase(gh<_i901.FoodRepoContract>()),
    );
    gh.factory<_i660.FoodCubit>(
      () => _i660.FoodCubit(
        gh<_i282.GetMealsCategoriesUseCase>(),
        gh<_i904.SelectMealsCategoryUseCase>(),
        gh<_i687.GetMealDetailsUseCase>(),
      ),
    );
    return this;
  }
}

class _$DiModule extends _i211.DiModule {}
