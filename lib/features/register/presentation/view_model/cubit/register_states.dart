import 'package:equatable/equatable.dart';
import 'package:flowery/core/base/base_state.dart';

// ignore: must_be_immutable
class RegisterState extends Equatable {
  BaseState<int>? currentStepState = const BaseState(data: 0);

  RegisterState({this.currentStepState});

  RegisterState copyWith({BaseState<int>? newCurrentStepState}) {
    return RegisterState(
      currentStepState: newCurrentStepState ?? currentStepState,
    );
  }

  @override
  List<Object?> get props => [currentStepState];
}