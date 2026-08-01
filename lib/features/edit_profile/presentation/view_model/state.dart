import 'package:flowery/core/base/base_state.dart';
import 'package:flowery/features/edit_profile/domain/entity/profile_entity.dart';

class EditProfileStates {
  final BaseState<ProfileEntity> profileState;
  final BaseState<ProfileEntity> editProfileState;
  final BaseState<ProfileEntity> uploadPhotoState;

  const EditProfileStates({
    this.profileState = const BaseState.initial(),
    this.editProfileState = const BaseState.initial(),
    this.uploadPhotoState = const BaseState.initial(),
  });

  EditProfileStates copyWith({
    BaseState<ProfileEntity>? profileState,
    BaseState<ProfileEntity>? editProfileState,
    BaseState<ProfileEntity>? uploadPhotoState,
  }) {
    return EditProfileStates(
      profileState: profileState ?? this.profileState,
      editProfileState: editProfileState ?? this.editProfileState,
      uploadPhotoState: uploadPhotoState ?? this.uploadPhotoState,
    );
  }
}
