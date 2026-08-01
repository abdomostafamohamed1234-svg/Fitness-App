import 'dart:developer';
import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/core/base/base_state.dart';
import 'package:flowery/features/profile/domain/entities/profile_entity.dart';
import 'package:flowery/features/profile/domain/usecase/profile_usecase.dart';
import 'package:flowery/features/profile/presentation/view_model/profile_event.dart';
import 'package:flowery/features/profile/presentation/view_model/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProfileCubit extends Cubit<ProfileStates> {
  final ProfileUseCase _profileUseCase;

  ProfileCubit(this._profileUseCase) : super(ProfileStates.initial());

  // ================== EVENTS ==================

  void doAction(ProfileEvents event) {
    switch (event) {
      case GetProfileDataEvent():
        _getProfileData();
    }
  }

  // ================== PROFILE ==================

  Future<void> _getProfileData() async {
    emit(state.copyWith(profileState: const BaseState.loading()));

    final Result<ProfileEntity> response =
        await _profileUseCase.callProfileData();

    switch (response) {
      case Success(:final data):
        emit(state.copyWith(profileState: BaseState.success(data)));
      case Error(:final exception):
        log(exception.toString());
        emit(state.copyWith(profileState: BaseState.error(exception)));
    }
  }

  @override
  void emit(ProfileStates state) {
    if (isClosed) return;
    super.emit(state);
  }
}