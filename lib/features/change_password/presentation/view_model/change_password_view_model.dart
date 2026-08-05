import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/change_password/domain/entities/change_password_response_entity.dart';
import 'package:flowery/features/change_password/domain/ues_case/change_password_use_case.dart';
import 'package:flowery/features/change_password/presentation/events/change_password_events.dart';
import 'package:flowery/features/change_password/presentation/states/change_password_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChangePasswordViewModel extends Cubit<ChangePasswordState> {
  final ChangePasswordUseCase _changePasswordUseCase;

  ChangePasswordViewModel(this._changePasswordUseCase)
    : super(const ChangePasswordState());

  void doEvent(ChangePasswordEvents event) {
    switch (event) {
      case ToggleOldPasswordVisibility():
        emit(state.copyWith(isOldPasswordVisible: !state.isOldPasswordVisible));
      case ToggleNewPasswordVisibility():
        emit(state.copyWith(isNewPasswordVisible: !state.isNewPasswordVisible));
      case ToggleConfirmPasswordVisibility():
        emit(
          state.copyWith(
            isConfirmPasswordVisible: !state.isConfirmPasswordVisible,
          ),
        );
      case UpdatePasswordEvent():
        _updatePassword(event);
    }
  }

  Future<void> _updatePassword(UpdatePasswordEvent event) async {
    emit(state.copyWith(isLoading: true, isDone: false));
    final response = await _changePasswordUseCase.call(
      event.password,
      event.newPassword,
    );
    switch (response) {
      case Success<ChangePasswordResponseEntity>():
        emit(
          state.copyWith(
            isLoading: false,
            isDone: true,
            message: response.data?.message,
          ),
        );
      case Error<ChangePasswordResponseEntity>():
        emit(
          state.copyWith(
            isLoading: false,
            isDone: true,
            message: response.exception.toString(),
          ),
        );
    }
  }
}
