import 'dart:io';

import 'package:flowery/config/exception_handlers/app_exception.dart';
import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/edit_profile/data/data_source/remote_data_source/edit_profile_remote_data_source_contract.dart';
import 'package:flowery/features/edit_profile/data/models/request/edit_profile_request_model.dart';
import 'package:flowery/features/edit_profile/data/models/response/profile_response_model.dart';
import 'package:flowery/features/edit_profile/data/models/response/user_response_model.dart';
import 'package:flowery/features/edit_profile/data/repo/edit_profile_repo_impl.dart';
import 'package:flowery/features/edit_profile/domain/entity/profile_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockEditProfileRemoteDataSource extends Mock
    implements EditProfileRemoteDataSourceContract {}

class _FakeFile extends Fake implements File {}

void main() {
  late _MockEditProfileRemoteDataSource remoteDataSource;
  late EditProfileRepoImpl repo;

  const request = EditProfileRequestModel(lastName: 'Tech2');

  setUpAll(() {
    registerFallbackValue(request);
    registerFallbackValue(_FakeFile());
  });

  setUp(() {
    remoteDataSource = _MockEditProfileRemoteDataSource();
    repo = EditProfileRepoImpl(remoteDataSource);
  });

  UserResponseModel buildUser() => UserResponseModel(
    id: '1',
    firstName: 'test',
    lastName: 'Tech2',
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

  group('getProfile', () {
    test('maps a successful response to a ProfileEntity', () async {
      final response = ProfileResponseModel(message: 'success', user: buildUser());
      when(() => remoteDataSource.getProfile())
          .thenAnswer((_) async => Success(data: response));

      final result = await repo.getProfile();

      expect(result, isA<Success<ProfileEntity>>());
      final entity = (result as Success<ProfileEntity>).data!;
      expect(entity.user?.firstName, 'test');
      expect(entity.user?.activityLevel, 'level1');
    });

    test('propagates the exception when the data source returns an Error', () async {
      const exception = AppException('failed');
      when(() => remoteDataSource.getProfile())
          .thenAnswer((_) async => const Error(exception: exception));

      final result = await repo.getProfile();

      expect(result, isA<Error<ProfileEntity>>());
      expect((result as Error<ProfileEntity>).exception, exception);
    });
  });

  group('editProfile', () {
    test('maps a successful response to a ProfileEntity', () async {
      final response = ProfileResponseModel(message: 'success', user: buildUser());
      when(() => remoteDataSource.editProfile(request))
          .thenAnswer((_) async => Success(data: response));

      final result = await repo.editProfile(request);

      expect(result, isA<Success<ProfileEntity>>());
      expect((result as Success<ProfileEntity>).data?.user?.lastName, 'Tech2');
    });
  });

  group('uploadPhoto', () {
    test('does not crash when the response has no user object', () async {
      final response = ProfileResponseModel(message: 'success');
      final photo = _FakeFile();
      when(() => remoteDataSource.uploadPhoto(any()))
          .thenAnswer((_) async => Success(data: response));

      final result = await repo.uploadPhoto(photo);

      expect(result, isA<Success<ProfileEntity>>());
      expect((result as Success<ProfileEntity>).data?.user, isNull);
    });
  });
}
