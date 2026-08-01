import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/core/base/base_state.dart';
import 'package:flowery/features/edit_profile/data/models/request/edit_profile_request_model.dart';
import 'package:flowery/features/edit_profile/domain/entity/profile_entity.dart';
import 'package:flowery/features/edit_profile/domain/use_case/edit_profile_use_case.dart';
import 'package:flowery/features/edit_profile/domain/use_case/get_profile_use_case.dart';
import 'package:flowery/features/edit_profile/domain/use_case/upload_photo_use_case.dart';
import 'package:flowery/features/edit_profile/presentation/view_model/event.dart';
import 'package:flowery/features/edit_profile/presentation/view_model/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class EditProfileCubit extends Cubit<EditProfileStates> {
  EditProfileCubit(
    this._getProfileUseCase,
    this._editProfileUseCase,
    this._uploadPhotoUseCase,
  ) : super(const EditProfileStates());

  final GetProfileUseCase _getProfileUseCase;
  final EditProfileUseCase _editProfileUseCase;
  final UploadPhotoUseCase _uploadPhotoUseCase;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();

  void doEvent(EditProfileEvents event) {
    switch (event) {
      case GetProfileEvent():
        _getProfile();

      case EditProfileEvent():
        _editProfile(event);

      case UploadPhotoEvent():
        _uploadPhoto(event);
    }
  }

  Future<void> _getProfile() async {
    emit(state.copyWith(profileState: const BaseState.loading()));

    final response = await _getProfileUseCase();

    switch (response) {
      case Success<ProfileEntity>():
        final user = response.data!.user;
        if (user != null) {
          firstNameController.text = user.firstName;
          lastNameController.text = user.lastName;
          emailController.text = user.email;
        }
        emit(state.copyWith(profileState: BaseState.success(response.data!)));

      case Error<ProfileEntity>():
        emit(state.copyWith(profileState: BaseState.error(response.exception!)));
    }
  }

  Future<void> _editProfile(EditProfileEvent event) async {
    emit(state.copyWith(editProfileState: const BaseState.loading()));

    final response = await _editProfileUseCase(
      EditProfileRequestModel(
        firstName: event.firstName,
        lastName: event.lastName,
        email: event.email,
        gender: event.gender,
        age: event.age,
        weight: event.weight,
        height: event.height,
        activityLevel: event.activityLevel,
        goal: event.goal,
      ),
    );

    switch (response) {
      case Success<ProfileEntity>():
        emit(state.copyWith(editProfileState: BaseState.success(response.data!)));

      case Error<ProfileEntity>():
        emit(state.copyWith(editProfileState: BaseState.error(response.exception!)));
    }
  }

  Future<void> _uploadPhoto(UploadPhotoEvent event) async {
    emit(state.copyWith(uploadPhotoState: const BaseState.loading()));

    final response = await _uploadPhotoUseCase(event.photo);

    switch (response) {
      case Success<ProfileEntity>():
        emit(state.copyWith(uploadPhotoState: BaseState.success(response.data!)));

      case Error<ProfileEntity>():
        emit(state.copyWith(uploadPhotoState: BaseState.error(response.exception!)));
    }
  }

  @override
  Future<void> close() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    return super.close();
  }
}
