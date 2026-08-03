import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/core/base/base_state.dart';
import 'package:flowery/features/login/data/models/request/login_request_model.dart';
import 'package:flowery/features/login/domain/entity/login_entity.dart';
import 'package:flowery/features/login/domain/use_case/login_use_case.dart';
import 'package:flowery/features/login/presentation/view_model/event.dart';
import 'package:flowery/features/login/presentation/view_model/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginCubit extends Cubit<LoginStates> {
  LoginCubit(this._loginUseCase) : super(const LoginStates());

  final LoginUseCase _loginUseCase;

  void doEvent(LoginEvents event) {
    switch (event) {
      case LoginEvent():
        _login(event);
        break;
    }
  }

  Future<void> _login(LoginEvent event) async {
    emit(
      state.copyWith(
        loginState: const BaseState.loading(),
      ),
    );

    final response = await _loginUseCase(
      LoginRequestModel(
        email: event.email,
        password: event.password,
      ),
    );

    switch (response) {
      case Success<LoginEntity>():
        emit(
          state.copyWith(
            loginState: BaseState.success(response.data!),
          ),
        );
        break;

      case Error<LoginEntity>():
        emit(
          state.copyWith(
            loginState: BaseState.error(response.exception!),
          ),
        );
        break;
    }
  }
}