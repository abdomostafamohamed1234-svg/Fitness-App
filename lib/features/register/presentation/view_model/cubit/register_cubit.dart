import 'dart:async';
import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/core/base/custom_cubit.dart';
import 'package:flowery/features/register/domain/entities/register_entity.dart';
import 'package:flowery/features/register/domain/use_cases/register_usecase.dart';
import 'package:flowery/features/register/presentation/view_model/cubit/register_events.dart';
import 'package:flowery/features/register/presentation/view_model/cubit/register_states.dart';
import 'package:flowery/features/register/presentation/view_model/cubit/register_temp_events.dart';
import 'package:flowery/core/base/base_state.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterCubit extends CustomCubit<RegisterTempEvents, RegisterState> {
  RegisterCubit(this._registerUsecase) : super(RegisterState());

  bool firstTime = true;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RegisterUsecase _registerUsecase;

  // Text controllers
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Register step data
  String? gender;
  int? age;
  int? weight;
  int? height;
  String? goal;
  String? physicalActivityLevel;

  void doIntent(RegisterEvent event) {
    switch (event) {
      case Register():
        _register();
      case RegisterNextStep():
        _nextStep();
      case RegisterPreviousStep():
        _previousStep();
      case NavigateToLoginEvent():
        _navigateToLogin();
      case ShowMassageEvent():
        _showMassage(event.massage);
      case ShowLoadingEvent():
        _showLoading();
      case HideLoadingEvent():
        _hideLoading();
    }
  }

  Future<void> _register() async {
    debugPrint('Gender: $gender');
debugPrint('Age: $age');
debugPrint('Weight: $weight');
debugPrint('Height: $height');
debugPrint('Goal: $goal');
debugPrint('Activity: $physicalActivityLevel');
    doIntent(ShowLoadingEvent());
    final response = await _registerUsecase.invoke({
      'firstName': firstNameController.text,
      'lastName': lastNameController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'rePassword': passwordController.text,
      'gender': gender,
      'height': height,
      'weight': weight,
      'age': age,
      'goal': goal,
      'activityLevel': physicalActivityLevel,
    });
    switch (response) {
      case Success<RegisterEntity>():
        doIntent(HideLoadingEvent());
        doIntent(ShowMassageEvent(response.data?.message?? 'Success!'));
        Future.delayed(
          const Duration(seconds: 2),
          () => streamController.add(NavigateToLoginTempEvent()),
        );
        emit(state);
      case Error<RegisterEntity>():
        doIntent(HideLoadingEvent());
        doIntent(ShowMassageEvent(response.exception?.toString() ?? 'Error'));
        emit(state);
    }
  }

  void _nextStep() {
    if (state.currentStepState?.data == null) {
      state.currentStepState = const BaseState(data: 0);
      emit(state);
      return;
    }
    final int current = state.currentStepState!.data!;
    emit(state.copyWith(newCurrentStepState: BaseState(data: current + 1)));
  }

  void _previousStep() {
    if (state.currentStepState?.data == 0) {
      streamController.add(NavigateToLoginTempEvent());
      emit(state);
      return;
    }
    final int current = state.currentStepState!.data!;
    emit(state.copyWith(newCurrentStepState: BaseState(data: current - 1)));
  }

  void _navigateToLogin() {
    streamController.add(NavigateToLoginTempEvent());
    emit(state);
  }

  void _showMassage(String massage) {
    streamController.add(ShowMassageTempEvent(massage));
    emit(state);
  }

  void _showLoading() {
    streamController.add(ShowLoadingTempEvent());
  }

  void _hideLoading() {
    streamController.add(HideLoadingTempEvent());
  }
}