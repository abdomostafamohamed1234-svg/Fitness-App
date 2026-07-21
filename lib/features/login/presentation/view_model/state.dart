import 'package:flowery/core/base/base_state.dart';
import 'package:flowery/features/login/domain/entity/login_entity.dart';

class LoginStates {
  final BaseState<LoginEntity> loginState;

  const LoginStates({
    this.loginState = const BaseState.initial(),
  });

  LoginStates copyWith({
    BaseState<LoginEntity>? loginState,
  }) {
    return LoginStates(
      loginState: loginState ?? this.loginState,
    );
  }
}