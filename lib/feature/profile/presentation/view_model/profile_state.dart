import 'package:flowery/core/base/base_state.dart';
import 'package:flowery/feature/profile/domain/entities/profile_entity.dart';


class ProfileStates {
  final BaseState<ProfileEntity> profileState;

  const ProfileStates({required this.profileState});

  factory ProfileStates.initial() {
    return const ProfileStates(profileState: BaseState.initial());
  }

  ProfileStates copyWith({BaseState<ProfileEntity>? profileState}) {
    return ProfileStates(
      profileState: profileState ?? this.profileState,
    );
  }
}