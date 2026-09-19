import 'package:flowery/core/base/base_state.dart';

class LogoutStates {
  final BaseState<void> logoutState;

  const LogoutStates({required this.logoutState});

  factory LogoutStates.initial() {
    return const LogoutStates(logoutState: BaseState.initial());
  }

  LogoutStates copyWith({BaseState<void>? logoutState}) {
    return LogoutStates(
      logoutState: logoutState ?? this.logoutState,
    );
  }
}