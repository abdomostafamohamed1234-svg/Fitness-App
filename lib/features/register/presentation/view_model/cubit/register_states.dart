import 'package:flowery/core/base/base_state.dart';

class RegisterState {
  BaseState<int>? registerState = const BaseState(data: 0);

  RegisterState({this.registerState});

  RegisterState copyWith({BaseState<int>? newRegisterState}) {
    return RegisterState(
      registerState: newRegisterState ?? registerState,
    );
  }
}