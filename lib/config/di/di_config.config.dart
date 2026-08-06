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
import '../../features/on_boarding/presentation/view_model/cubit/on_boarding_cubit.dart'
    as _i786;
import '../../features/register/api/api_client/register_api_client.dart'
    as _i656;
import '../../features/register/api/datasources/register_remote_data_source_impl.dart'
    as _i754;
import '../../features/register/data/datasources/register_remote_data_source_contract.dart'
    as _i703;
import '../../features/register/data/repositories/register_repository_impl.dart'
    as _i68;
import '../../features/register/domain/repositories/register_repository.dart'
    as _i994;
import '../../features/register/domain/use_cases/register_usecase.dart'
    as _i679;
import '../../features/register/presentation/view_model/cubit/register_cubit.dart'
    as _i278;
import '../../features/app_sections/presentation/view_model/cubit/app_sections_cubit.dart'
    as _i1038;
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
import '../../features/exercises/api/api_client/exercise_api_client.dart'
    as _i79;
import '../../features/exercises/api/data_source/exercise_data_source_impl.dart'
    as _i1043;
import '../../features/exercises/data/data_source/exercise_data_sourse_contract.dart'
    as _i675;
import '../../features/exercises/data/repo/exercise_repo_impl.dart' as _i42;
import '../../features/exercises/domain/repo/exercise_repo_contract.dart'
    as _i523;
import '../../features/exercises/domain/use_case/exercise_use_case_.dart'
    as _i517;
import '../../features/exercises/domain/use_case/levels_use_case.dart' as _i720;
import '../../features/exercises/presentation/view_model/cubit/exercise_cubit.dart'
    as _i82;
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
import '../../features/home/api/api_client/home_api_client.dart' as _i592;
import '../../features/home/api/datasourse/home_remote_datasourse_impl.dart'
    as _i792;
import '../../features/home/data/datasourse/home_remote_datasourse_contract.dart'
    as _i340;
import '../../features/home/data/datasourse/home_remote_datasourse_impl.dart'
    as _i656;
import '../../features/home/data/repository/home_repository_impl.dart' as _i9;
import '../../features/home/domian/repository/home_repository_contract.dart'
    as _i689;
import '../../features/home/domian/use_case/use_case.dart' as _i497;
import '../../features/home/presentation/view_model/home_cubit.dart' as _i940;
import '../../features/on_boarding/presentation/view_model/cubit/on_boarding_cubit.dart'
    as _i786;
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
    gh.factory<_i656.RegisterApiClient>(
      () => _i656.RegisterApiClient(gh<_i361.Dio>()),
    gh.lazySingleton<_i244.ChangePasswordApiClient>(
      () => _i244.ChangePasswordApiClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i892.ForgetPasswordApiClient>(
      () => _i892.ForgetPasswordApiClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i123.WorkoutsApiClient>(
      () => _i123.WorkoutsApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i79.ExerciseApiClient>(
      () => _i79.ExerciseApiClient(gh<_i361.Dio>()),
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
    gh.singleton<_i361.Dio>(
      () => diModule.mealsDio(),
      instanceName: 'mealsDio',
    );
    gh.factory<_i703.RegisterRemoteDataSourceContract>(
      () => _i754.RegisterRemoteDataSourceImpl(gh<_i656.RegisterApiClient>()),
    );
    gh.factory<_i994.RegisterRepository>(
      () => _i68.RegisterRepositoryImpl(
        gh<_i703.RegisterRemoteDataSourceContract>(),
      ),
    );
    gh.factory<_i679.RegisterUsecase>(
      () => _i679.RegisterUsecase(gh<_i994.RegisterRepository>()),
    );
    gh.factory<_i278.RegisterCubit>(
      () => _i278.RegisterCubit(gh<_i679.RegisterUsecase>()),
    gh.factory<_i793.ChangePasswordLocalDataSourceImplementation>(
      () => _i793.ChangePasswordLocalDataSourceImplementation(
        gh<_i558.FlutterSecureStorage>(),
      ),
    );
    gh.factory<_i539.PopularTrainingRepository>(
      () => _i234.PopularTrainingRepositoryImpl(
        gh<_i439.PopularTrainingRemoteDataSource>(),
      ),
    );
    gh.factory<_i675.ExerciseDataSourceContract>(
      () => _i1043.ExerciseDataSourceImpl(gh<_i79.ExerciseApiClient>()),
    );
    gh.factory<_i1048.GetPopularTrainingUseCase>(
      () => _i1048.GetPopularTrainingUseCase(
        gh<_i539.PopularTrainingRepository>(),
      ),
    );
    gh.factory<_i689.HomeRepositoryContract>(
      () => _i9.HomeRepositoryImpl(gh<_i340.HomeRemoteDataSourceContract>()),
    );
    gh.factory<_i492.ForgetPasswordDataSourceContract>(
      () => _i495.ForgetPasswordDataSourceImp(
        gh<_i892.ForgetPasswordApiClient>(),
      ),
    );
    gh.factory<_i656.HomeRemoteDataSourceContract>(
      () => _i792.HomeRemoteDataSourceImpl(gh<_i592.HomeApiClient>()),
    );
    gh.factory<_i310.FoodApiClient>(
      () => _i310.FoodApiClient(gh<_i361.Dio>(instanceName: 'mealsDio')),
    );
    gh.factory<_i695.PopularTrainingCubit>(
      () => _i695.PopularTrainingCubit(gh<_i1048.GetPopularTrainingUseCase>()),
    );
    gh.factory<_i665.ForgetPasswordRepoContract>(
      () => _i32.ForgetPasswordRepoImp(
        gh<_i492.ForgetPasswordDataSourceContract>(),
      ),
    );
    gh.factory<_i167.ChangePasswordRemoteDataSourceContract>(
      () => _i577.ChangePasswordRemoteDataSourceImp(
        gh<_i244.ChangePasswordApiClient>(),
      ),
    );
    gh.factory<_i668.WorkoutRemoteDataSourceContract>(
      () => _i355.WorkoutsRemoteDataSourceImpl(gh<_i123.WorkoutsApiClient>()),
    );
    gh.factory<_i523.ExerciseRepoContract>(
      () => _i42.ExerciseRepoImpl(gh<_i675.ExerciseDataSourceContract>()),
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
    gh.factory<_i497.HomeUseCase>(
      () => _i497.HomeUseCase(gh<_i689.HomeRepositoryContract>()),
    );
    gh.factory<_i656.FoodRemoteDataSourceContract>(
      () => _i58.FoodRemoteDataSourceImpl(gh<_i310.FoodApiClient>()),
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
    gh.factory<_i333.ChangePasswordRepoContract>(
      () => _i49.ChangePasswordRepoImp(
        gh<_i167.ChangePasswordRemoteDataSourceContract>(),
        gh<_i110.ChangePasswordLocalDataSourceContract>(),
      ),
    );
    gh.factory<_i517.ExerciseUseCase>(
      () => _i517.ExerciseUseCase(gh<_i523.ExerciseRepoContract>()),
    );
    gh.factory<_i720.LevelsUseCase>(
      () => _i720.LevelsUseCase(gh<_i523.ExerciseRepoContract>()),
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
    );
    gh.factory<_i534.ChangePasswordUseCase>(
      () => _i534.ChangePasswordUseCase(gh<_i333.ChangePasswordRepoContract>()),
    );
    gh.factory<_i940.HomeCubit>(() => _i940.HomeCubit(gh<_i497.HomeUseCase>()));
    gh.factory<_i82.ExerciseCubit>(
      () => _i82.ExerciseCubit(
        gh<_i720.LevelsUseCase>(),
        gh<_i517.ExerciseUseCase>(),
      ),
    );
    gh.factory<_i969.ChangePasswordViewModel>(
      () => _i969.ChangePasswordViewModel(gh<_i534.ChangePasswordUseCase>()),
    );
    gh.factory<_i152.WorkoutsCubit>(
      () => _i152.WorkoutsCubit(
        gh<_i249.GetMusclesGroupUseCase>(),
        gh<_i350.GetMusclesGroupByIdUseCase>(),
      ),
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
