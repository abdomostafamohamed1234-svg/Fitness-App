import 'package:flowery/core/base/base_state.dart';

class RegisterStates {
  BaseState<int>? registerState = const BaseState(data: 0);

  RegisterStates({this.registerState});

  RegisterStates copyWith({BaseState<int>? newRegisterState}) {
    return RegisterStates(
      registerState: newRegisterState ?? registerState,
    );
  }
}