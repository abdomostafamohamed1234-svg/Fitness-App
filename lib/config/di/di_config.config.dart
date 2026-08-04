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
import '../../features/change_password/api/api_client/change_password_api_client.dart'
    as _i244;
import '../../features/change_password/api/data_source/change_password_local_data_source_implementation.dart'
    as _i793;
import '../../features/change_password/api/data_source/change_password_remote_data_source_imp.dart'
    as _i577;
import '../../features/change_password/data/data_source/change_password_local_data_source_contract.dart'
    as _i110;
import '../../features/change_password/data/data_source/change_password_remote_data_source_contract.dart'
    as _i167;
import '../../features/change_password/data/repo/change_password_repo_imp.dart'
    as _i49;
import '../../features/change_password/domain/repo/change_password_repo_contract.dart'
    as _i333;
import '../../features/change_password/domain/ues_case/change_password_use_case.dart'
    as _i534;
import '../../features/change_password/presentation/view_model/change_password_view_model.dart'
    as _i969;
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
import '../../features/forget_password/api/api_client/forget_password_api_client.dart'
    as _i892;
import '../../features/forget_password/api/data_source/forget_password_data_source_imp.dart'
    as _i495;
import '../../features/forget_password/data/data_source/forget_password_data_source_contract.dart'
    as _i492;
import '../../features/forget_password/data/repo/forget_password_repo_imp.dart'
    as _i32;
import '../../features/forget_password/domain/repo/forget_password_repo_contract.dart'
    as _i665;
import '../../features/forget_password/domain/use_cases/forget_password_use_case.dart'
    as _i437;
import '../../features/forget_password/domain/use_cases/reset_password_use_case.dart'
    as _i56;
import '../../features/forget_password/domain/use_cases/verify_email_use_case.dart'
    as _i524;
import '../../features/forget_password/presentation/view_models/cubit/forget_password_view_model.dart'
    as _i916;
import '../../features/app_sections/presentation/view_model/cubit/app_sections_cubit.dart'
    as _i1038;
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
    gh.factory<_i1038.AppSectionsCubit>(() => _i1038.AppSectionsCubit());
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
    gh.lazySingleton<_i892.ForgetPasswordApiClient>(
      () => _i892.ForgetPasswordApiClient(gh<_i361.Dio>()),
    gh.lazySingleton<_i244.ChangePasswordApiClient>(
      () => _i244.ChangePasswordApiClient(gh<_i361.Dio>()),
    );
    gh.singleton<_i361.Dio>(
      () => diModule.mealsDio(),
      instanceName: 'mealsDio',
    );
    gh.factory<_i492.ForgetPasswordDataSourceContract>(
      () => _i495.ForgetPasswordDataSourceImp(
        gh<_i892.ForgetPasswordApiClient>(),
    gh.factory<_i793.ChangePasswordLocalDataSourceImplementation>(
      () => _i793.ChangePasswordLocalDataSourceImplementation(
        gh<_i558.FlutterSecureStorage>(),
      ),
    );
    gh.factory<_i310.FoodApiClient>(
      () => _i310.FoodApiClient(gh<_i361.Dio>(instanceName: 'mealsDio')),
    );
    gh.factory<_i665.ForgetPasswordRepoContract>(
      () => _i32.ForgetPasswordRepoImp(
        gh<_i492.ForgetPasswordDataSourceContract>(),
      ),
    );
    gh.factory<_i437.ForgetPasswordUseCase>(
      () => _i437.ForgetPasswordUseCase(gh<_i665.ForgetPasswordRepoContract>()),
    );
    gh.factory<_i56.ResetPasswordUseCase>(
      () => _i56.ResetPasswordUseCase(gh<_i665.ForgetPasswordRepoContract>()),
    );
    gh.factory<_i524.VerifyEmailUseCase>(
      () => _i524.VerifyEmailUseCase(gh<_i665.ForgetPasswordRepoContract>()),
    );
    gh.factory<_i656.FoodRemoteDataSourceContract>(
      () => _i58.FoodRemoteDataSourceImpl(gh<_i310.FoodApiClient>()),
    );
    gh.factory<_i901.FoodRepoContract>(
      () => _i20.FoodRepoImpl(gh<_i656.FoodRemoteDataSourceContract>()),
    );
    gh.factory<_i916.ForgetPasswordViewModel>(
      () => _i916.ForgetPasswordViewModel(
        gh<_i437.ForgetPasswordUseCase>(),
        gh<_i524.VerifyEmailUseCase>(),
        gh<_i56.ResetPasswordUseCase>(),
      ),
    gh.factory<_i167.ChangePasswordRemoteDataSourceContract>(
      () => _i577.ChangePasswordRemoteDataSourceImp(
        gh<_i244.ChangePasswordApiClient>(),
      ),
    );
    gh.factory<_i656.FoodRemoteDataSourceContract>(
      () => _i58.FoodRemoteDataSourceImpl(gh<_i310.FoodApiClient>()),
    );
    gh.factory<_i333.ChangePasswordRepoContract>(
      () => _i49.ChangePasswordRepoImp(
        gh<_i167.ChangePasswordRemoteDataSourceContract>(),
        gh<_i110.ChangePasswordLocalDataSourceContract>(),
      ),
    );
    gh.factory<_i901.FoodRepoContract>(
      () => _i20.FoodRepoImpl(gh<_i656.FoodRemoteDataSourceContract>()),
    );
    gh.factory<_i534.ChangePasswordUseCase>(
      () => _i534.ChangePasswordUseCase(gh<_i333.ChangePasswordRepoContract>()),
    );
    gh.factory<_i969.ChangePasswordViewModel>(
      () => _i969.ChangePasswordViewModel(gh<_i534.ChangePasswordUseCase>()),
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
