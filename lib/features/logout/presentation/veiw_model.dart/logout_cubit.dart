import 'dart:developer';
import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/core/base/base_state.dart';
import 'package:flowery/features/logout/domian/usecase/logout_usecase.dart';
import 'package:flowery/features/logout/presentation/veiw_model.dart/logout_event.dart';
import 'package:flowery/features/logout/presentation/veiw_model.dart/logout_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LogoutCubit extends Cubit<LogoutStates> {
  final LogoutUseCase _logoutUseCase;

  LogoutCubit(this._logoutUseCase) : super(LogoutStates.initial());

  void doAction(LogoutEvents event) {
    switch (event) {
      case DoLogoutEvent():
        _logout();
    }
  }

  Future<void> _logout() async {
    emit(state.copyWith(logoutState: const BaseState.loading()));

    final Result<void> response = await _logoutUseCase();

    switch (response) {
      case Success():
        emit(state.copyWith(logoutState: const BaseState.success(null)));
      case Error(:final exception):
        log(exception.toString());
        emit(state.copyWith(logoutState: BaseState.error(exception)));
    }
  }

  @override
  void emit(LogoutStates state) {
    if (isClosed) return;
    super.emit(state);
  }
}