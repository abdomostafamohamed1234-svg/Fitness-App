// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart' as _i806;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:google_sign_in/google_sign_in.dart' as _i116;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../core/cubits/locale/locale_cubit.dart' as _i273;
import '../../core/utils/sha256_social_password_generator.dart' as _i746;
import '../../core/utils/social_password_generator.dart' as _i490;
import '../../features/auth_with_social_media/data/data_source/social_auth_data_source.dart'
    as _i606;
import '../../features/auth_with_social_media/data/data_source/social_auth_data_source_impl.dart'
    as _i594;
import '../../features/auth_with_social_media/data/repo/social_repo_impl.dart'
    as _i762;
import '../../features/auth_with_social_media/domain/repo/social_repo_contract.dart'
    as _i709;
import '../../features/auth_with_social_media/domain/use_case/create_social_session_use_case.dart'
    as _i763;
import '../../features/auth_with_social_media/domain/use_case/facebook_login_use_case.dart'
    as _i307;
import '../../features/auth_with_social_media/domain/use_case/google_login_use_case.dart'
    as _i346;
import '../../features/auth_with_social_media/domain/use_case/sign_out_use_case.dart'
    as _i254;
import '../../features/auth_with_social_media/presentation/view_model/cubit/social_auth_cubit.dart'
    as _i260;
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
import '../../features/home/data/datasourse/home_remote_datasourse_impl.dart'
    as _i656;
import '../../features/home/data/repository/home_repository_impl.dart' as _i9;
import '../../features/home/domian/repository/home_repository_contract.dart'
    as _i689;
import '../../features/home/domian/use_case/use_case.dart' as _i497;
import '../../features/home/presentation/view_model/home_cubit.dart' as _i940;
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
import '../helpers/shared_preferences/shared_preferences_helper.dart' as _i425;
import 'di_module.dart' as _i211;
import 'firebase_module.dart' as _i616;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final diModule = _$DiModule();
    final firebaseModule = _$FirebaseModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => diModule.sharedPreferences(),
      preResolve: true,
    );
    gh.factory<_i786.OnBoardingCubit>(() => _i786.OnBoardingCubit());
    gh.singleton<_i361.Dio>(() => diModule.dio());
    gh.singleton<_i59.FirebaseAuth>(() => firebaseModule.firebaseAuth);
    gh.singleton<_i116.GoogleSignIn>(() => firebaseModule.googleSignIn);
    gh.singleton<_i806.FacebookAuth>(() => firebaseModule.facebookAuth);
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => diModule.secureStorage(),
    );
    gh.factory<_i425.SharedPreferencesHelper>(
      () => _i425.SharedPreferencesHelper(gh<_i460.SharedPreferences>()),
    );
    gh.factory<_i273.LocaleCubit>(
      () => _i273.LocaleCubit(gh<_i425.SharedPreferencesHelper>()),
    );
    gh.lazySingleton<_i892.ForgetPasswordApiClient>(
      () => _i892.ForgetPasswordApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i592.HomeApiClient>(() => _i592.HomeApiClient(gh<_i361.Dio>()));
    gh.factory<_i387.LoginApiClient>(
      () => _i387.LoginApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i656.RegisterApiClient>(
      () => _i656.RegisterApiClient(gh<_i361.Dio>()),
    );
    gh.singleton<_i361.Dio>(
      () => diModule.mealsDio(),
      instanceName: 'mealsDio',
    );
    gh.singleton<_i490.SocialPasswordGenerator>(
      () => _i746.Sha256SocialPasswordGenerator(),
    );
    gh.factory<_i606.SocialAuthDataSourceContract>(
      () => _i594.SocialAuthDataSourceImpl(
        gh<_i59.FirebaseAuth>(),
        gh<_i116.GoogleSignIn>(),
        gh<_i806.FacebookAuth>(),
      ),
    );
    gh.factory<_i763.CreateSocialSessionUseCase>(
      () =>
          _i763.CreateSocialSessionUseCase(gh<_i490.SocialPasswordGenerator>()),
    );
    gh.factory<_i80.LoginRemoteDataSourceContract>(
      () => _i365.LoginRemoteDataSourceImpl(gh<_i387.LoginApiClient>()),
    );
    gh.factory<_i703.RegisterRemoteDataSourceContract>(
      () => _i754.RegisterRemoteDataSourceImpl(gh<_i656.RegisterApiClient>()),
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
    gh.factory<_i665.ForgetPasswordRepoContract>(
      () => _i32.ForgetPasswordRepoImp(
        gh<_i492.ForgetPasswordDataSourceContract>(),
      ),
    );
    gh.factory<_i709.SocialAuthRepoContract>(
      () => _i762.SocialAuthRepoImpl(gh<_i606.SocialAuthDataSourceContract>()),
    );
    gh.factory<_i994.RegisterRepository>(
      () => _i68.RegisterRepositoryImpl(
        gh<_i703.RegisterRemoteDataSourceContract>(),
      ),
    );
    gh.factory<_i679.RegisterUsecase>(
      () => _i679.RegisterUsecase(gh<_i994.RegisterRepository>()),
    );
    gh.factory<_i689.HomeRepositoryContract>(
      () => _i9.HomeRepositoryImpl(gh<_i656.HomeRemoteDataSourceContract>()),
    );
    gh.factory<_i278.RegisterCubit>(
      () => _i278.RegisterCubit(gh<_i679.RegisterUsecase>()),
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
    gh.factory<_i202.LoginRepoContract>(
      () => _i176.LoginRepoImpl(gh<_i80.LoginRemoteDataSourceContract>()),
    );
    gh.factory<_i307.FacebookSignInUseCase>(
      () => _i307.FacebookSignInUseCase(gh<_i709.SocialAuthRepoContract>()),
    );
    gh.factory<_i346.GoogleSignInUseCase>(
      () => _i346.GoogleSignInUseCase(gh<_i709.SocialAuthRepoContract>()),
    );
    gh.factory<_i254.SignOutUseCase>(
      () => _i254.SignOutUseCase(gh<_i709.SocialAuthRepoContract>()),
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
    gh.factory<_i916.ForgetPasswordViewModel>(
      () => _i916.ForgetPasswordViewModel(
        gh<_i437.ForgetPasswordUseCase>(),
        gh<_i524.VerifyEmailUseCase>(),
        gh<_i56.ResetPasswordUseCase>(),
      ),
    );
    gh.factory<_i260.SocialAuthBloc>(
      () => _i260.SocialAuthBloc(
        gh<_i346.GoogleSignInUseCase>(),
        gh<_i307.FacebookSignInUseCase>(),
        gh<_i254.SignOutUseCase>(),
        gh<_i763.CreateSocialSessionUseCase>(),
        gh<_i168.LoginUseCase>(),
      ),
    );
    gh.factory<_i940.HomeCubit>(() => _i940.HomeCubit(gh<_i497.HomeUseCase>()));
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

class _$FirebaseModule extends _i616.FirebaseModule {}
