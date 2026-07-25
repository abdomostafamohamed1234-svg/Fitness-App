import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/auth_with_social_media/domain/entities/social_auth_result.dart';
import 'package:flowery/features/auth_with_social_media/domain/entities/social_user_entity.dart';
import 'package:flowery/features/auth_with_social_media/domain/use_case/create_social_session_use_case.dart';
import 'package:flowery/features/auth_with_social_media/domain/use_case/facebook_login_use_case.dart';
import 'package:flowery/features/auth_with_social_media/domain/use_case/google_login_use_case.dart';
import 'package:flowery/features/auth_with_social_media/domain/use_case/sign_out_use_case.dart';
import 'package:flowery/features/auth_with_social_media/presentation/view_model/events/social_auth_event.dart';
import 'package:flowery/features/auth_with_social_media/presentation/view_model/base_state/social_auth_state.dart';

@injectable
class SocialAuthBloc extends Bloc<SocialAuthEvent, SocialAuthState> {
  final GoogleSignInUseCase _googleSignInUseCase;
  final FacebookSignInUseCase _facebookSignInUseCase;
  final SignOutUseCase _signOutUseCase;
  final CreateSocialSessionUseCase _createSocialSessionUseCase;
  final LoginUseCase _loginUseCase;

  SocialAuthBloc(
    this._googleSignInUseCase,
    this._facebookSignInUseCase,
    this._signOutUseCase,
    this._createSocialSessionUseCase,
    this._loginUseCase,
  ) : super(const SocialAuthState.initial()) {
    on<GoogleSignInEvent>(_googleLogin);
    on<FacebookSignInEvent>(_facebookLogin);
    on<SignOutEvent>(_signOut);
  }

  Future<void> _googleLogin(
    GoogleSignInEvent event,
    Emitter<SocialAuthState> emit,
  ) async {
    await _handleSocialLogin(_googleSignInUseCase.invoke, emit);
  }

  Future<void> _facebookLogin(
    FacebookSignInEvent event,
    Emitter<SocialAuthState> emit,
  ) async {
    await _handleSocialLogin(_facebookSignInUseCase.invoke, emit);
  }

  Future<void> _handleSocialLogin(
    Future<Result<SocialUserEntity>> Function() socialLoginMethod,
    Emitter<SocialAuthState> emit,
  ) async {
    emit(const SocialAuthState.loading());

    final socialResult = await socialLoginMethod();

    switch (socialResult) {
      case Success<SocialUserEntity>():
        final session = _createSocialSessionUseCase.invoke(socialResult.data!);
        final loginResult = await _loginUseCase.call(
          LoginRequestModel(
            email: session.user.email,
            password: session.generatedPassword,
          ),
        );

        switch (loginResult) {
          case Success<LoginEntity>():
            emit(
              SocialAuthState.success(
                ExistingUserAuthResult(loginResult.data!),
              ),
            );

          case Error<LoginEntity>():
            emit(SocialAuthState.success(NewUserAuthResult(session)));
        }

      case Error<SocialUserEntity>():
        emit(SocialAuthState.error(socialResult.exception));
    }
  }

  Future<void> _signOut(
    SignOutEvent event,
    Emitter<SocialAuthState> emit,
  ) async {
    await _signOutUseCase.invoke();

    emit(const SocialAuthState.initial());
  }
}
