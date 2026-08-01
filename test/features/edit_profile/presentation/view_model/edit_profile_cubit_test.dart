import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/core/base/base_state.dart';
import 'package:flowery/features/edit_profile/data/models/request/edit_profile_request_model.dart';
import 'package:flowery/features/edit_profile/domain/entity/profile_entity.dart';
import 'package:flowery/features/edit_profile/domain/entity/user_entity.dart';
import 'package:flowery/features/edit_profile/domain/use_case/edit_profile_use_case.dart';
import 'package:flowery/features/edit_profile/domain/use_case/get_profile_use_case.dart';
import 'package:flowery/features/edit_profile/domain/use_case/upload_photo_use_case.dart';
import 'package:flowery/features/edit_profile/presentation/view_model/cubit.dart';
import 'package:flowery/features/edit_profile/presentation/view_model/event.dart';
import 'package:flowery/features/edit_profile/presentation/view_model/state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockGetProfileUseCase extends Mock implements GetProfileUseCase {}

class _MockEditProfileUseCase extends Mock implements EditProfileUseCase {}

class _MockUploadPhotoUseCase extends Mock implements UploadPhotoUseCase {}

class _FakeFile extends Fake implements File {}

void main() {
  late _MockGetProfileUseCase getProfileUseCase;
  late _MockEditProfileUseCase editProfileUseCase;
  late _MockUploadPhotoUseCase uploadPhotoUseCase;

  final user = UserEntity(
    id: '1',
    firstName: 'test',
    lastName: 'test',
    email: 'tadrous@gmail.com',
    gender: 'male',
    age: 70,
    weight: 70,
    height: 170,
    activityLevel: 'level1',
    goal: 'Gain weight',
    photo: 'https://fitness.elevateegy.com/uploads/default-profile.png',
    createdAt: DateTime(2026, 7, 21),
  );
  late final ProfileEntity profile = ProfileEntity(message: 'success', user: user);

  setUpAll(() {
    registerFallbackValue(const EditProfileRequestModel());
    registerFallbackValue(_FakeFile());
  });

  setUp(() {
    getProfileUseCase = _MockGetProfileUseCase();
    editProfileUseCase = _MockEditProfileUseCase();
    uploadPhotoUseCase = _MockUploadPhotoUseCase();
  });

  EditProfileCubit buildCubit() =>
      EditProfileCubit(getProfileUseCase, editProfileUseCase, uploadPhotoUseCase);

  TypeMatcher<EditProfileStates> stateMatcher({
    StateType? profile,
    StateType? edit,
    StateType? upload,
  }) {
    var matcher = isA<EditProfileStates>();
    if (profile != null) {
      matcher = matcher.having((s) => s.profileState.state, 'profileState', profile);
    }
    if (edit != null) {
      matcher = matcher.having((s) => s.editProfileState.state, 'editProfileState', edit);
    }
    if (upload != null) {
      matcher = matcher.having((s) => s.uploadPhotoState.state, 'uploadPhotoState', upload);
    }
    return matcher;
  }

  group('GetProfileEvent', () {
    blocTest<EditProfileCubit, EditProfileStates>(
      'emits [loading, success] and fills the text controllers when it succeeds',
      build: () {
        when(() => getProfileUseCase()).thenAnswer((_) async => Success(data: profile));
        return buildCubit();
      },
      act: (cubit) => cubit.doEvent(GetProfileEvent()),
      expect: () => [
        stateMatcher(profile: StateType.loading),
        stateMatcher(profile: StateType.success),
      ],
      verify: (cubit) {
        expect(cubit.firstNameController.text, 'test');
        expect(cubit.lastNameController.text, 'test');
        expect(cubit.emailController.text, 'tadrous@gmail.com');
      },
    );

    blocTest<EditProfileCubit, EditProfileStates>(
      'emits [loading, error] when it fails',
      build: () {
        when(() => getProfileUseCase()).thenAnswer(
          (_) async => const Error(exception: FormatException('network down')),
        );
        return buildCubit();
      },
      act: (cubit) => cubit.doEvent(GetProfileEvent()),
      expect: () => [
        stateMatcher(profile: StateType.loading),
        stateMatcher(profile: StateType.error),
      ],
    );

    blocTest<EditProfileCubit, EditProfileStates>(
      'does not crash and leaves the controllers empty when the response has no user',
      build: () {
        when(() => getProfileUseCase()).thenAnswer(
          (_) async => const Success(data: ProfileEntity(message: 'success')),
        );
        return buildCubit();
      },
      act: (cubit) => cubit.doEvent(GetProfileEvent()),
      expect: () => [
        stateMatcher(profile: StateType.loading),
        stateMatcher(profile: StateType.success),
      ],
      verify: (cubit) {
        expect(cubit.firstNameController.text, isEmpty);
      },
    );
  });

  group('EditProfileEvent', () {
    blocTest<EditProfileCubit, EditProfileStates>(
      'emits [loading, success] when it succeeds',
      build: () {
        when(() => editProfileUseCase(any())).thenAnswer((_) async => Success(data: profile));
        return buildCubit();
      },
      act: (cubit) => cubit.doEvent(EditProfileEvent(lastName: 'Tech2')),
      expect: () => [
        stateMatcher(edit: StateType.loading),
        stateMatcher(edit: StateType.success),
      ],
    );

    blocTest<EditProfileCubit, EditProfileStates>(
      'emits [loading, error] when it fails',
      build: () {
        when(() => editProfileUseCase(any())).thenAnswer(
          (_) async => const Error(exception: FormatException('invalid field')),
        );
        return buildCubit();
      },
      act: (cubit) => cubit.doEvent(EditProfileEvent(lastName: 'Tech2')),
      expect: () => [
        stateMatcher(edit: StateType.loading),
        stateMatcher(edit: StateType.error),
      ],
    );
  });

  group('UploadPhotoEvent', () {
    blocTest<EditProfileCubit, EditProfileStates>(
      'emits [loading, success] when it succeeds',
      build: () {
        when(() => uploadPhotoUseCase(any())).thenAnswer((_) async => Success(data: profile));
        return buildCubit();
      },
      act: (cubit) => cubit.doEvent(UploadPhotoEvent(_FakeFile())),
      expect: () => [
        stateMatcher(upload: StateType.loading),
        stateMatcher(upload: StateType.success),
      ],
    );

    blocTest<EditProfileCubit, EditProfileStates>(
      'emits [loading, error] when it fails',
      build: () {
        when(() => uploadPhotoUseCase(any())).thenAnswer(
          (_) async => const Error(exception: FormatException('upload failed')),
        );
        return buildCubit();
      },
      act: (cubit) => cubit.doEvent(UploadPhotoEvent(_FakeFile())),
      expect: () => [
        stateMatcher(upload: StateType.loading),
        stateMatcher(upload: StateType.error),
      ],
    );
  });
}
