import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flowery/config/di/di_config.dart';
import 'package:flowery/config/helpers/shared_preferences/shared_preferences_helper.dart';
import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/edit_profile/api/edit_profile_api_client.dart';
import 'package:flowery/features/edit_profile/data/data_source/remote_data_source/edit_profile_remote_data_source_impl.dart';
import 'package:flowery/features/edit_profile/data/models/request/edit_profile_request_model.dart';
import 'package:flowery/features/edit_profile/data/models/response/profile_response_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockEditProfileApiClient extends Mock implements EditProfileApiClient {}

class _MockSharedPreferencesHelper extends Mock implements SharedPreferencesHelper {}

class _FakeFile extends Fake implements File {
  @override
  String get path => 'fake/path/photo.jpg';
}

void main() {
  late _MockEditProfileApiClient apiClient;
  late EditProfileRemoteDataSourceImpl dataSource;

  const request = EditProfileRequestModel(lastName: 'Tech2');

  setUpAll(() {
    registerFallbackValue(request);
    registerFallbackValue(_FakeFile());
  });

  setUp(() {
    apiClient = _MockEditProfileApiClient();
    dataSource = EditProfileRemoteDataSourceImpl(apiClient);

    final fakePrefsHelper = _MockSharedPreferencesHelper();
    when(() => fakePrefsHelper.getString('locale')).thenReturn('en');
    getIt.registerSingleton<SharedPreferencesHelper>(fakePrefsHelper);
  });

  tearDown(() {
    getIt.reset();
  });

  group('getProfile', () {
    test('returns Success with the response when the api call succeeds', () async {
      final response = ProfileResponseModel(message: 'success');
      when(() => apiClient.getProfile()).thenAnswer((_) async => response);

      final result = await dataSource.getProfile();

      expect(result, isA<Success<ProfileResponseModel>>());
      expect((result as Success<ProfileResponseModel>).data, response);
    });

    test('returns Error with a handled AppException when a DioException is thrown', () async {
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/auth/profile-data'),
        type: DioExceptionType.connectionTimeout,
      );
      when(() => apiClient.getProfile()).thenThrow(dioException);

      final result = await dataSource.getProfile();

      expect(result, isA<Error<ProfileResponseModel>>());
      expect((result as Error<ProfileResponseModel>).exception, isNotNull);
    });

    test('returns Error with an AppException when a generic Exception is thrown', () async {
      when(() => apiClient.getProfile()).thenThrow(Exception('boom'));

      final result = await dataSource.getProfile();

      expect(result, isA<Error<ProfileResponseModel>>());
      expect((result as Error<ProfileResponseModel>).exception.toString(), contains('boom'));
    });
  });

  group('editProfile', () {
    test('returns Success with the response when the api call succeeds', () async {
      final response = ProfileResponseModel(message: 'success');
      when(() => apiClient.editProfile(request)).thenAnswer((_) async => response);

      final result = await dataSource.editProfile(request);

      expect(result, isA<Success<ProfileResponseModel>>());
      expect((result as Success<ProfileResponseModel>).data, response);
    });

    test('returns Error when a DioException is thrown', () async {
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/auth/editProfile'),
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: RequestOptions(path: '/auth/editProfile'),
          statusCode: 400,
        ),
      );
      when(() => apiClient.editProfile(request)).thenThrow(dioException);

      final result = await dataSource.editProfile(request);

      expect(result, isA<Error<ProfileResponseModel>>());
    });
  });

  group('uploadPhoto', () {
    test('returns Success with the response when the api call succeeds', () async {
      final response = ProfileResponseModel(message: 'success');
      final photo = _FakeFile();
      when(() => apiClient.uploadPhoto(any())).thenAnswer((_) async => response);

      final result = await dataSource.uploadPhoto(photo);

      expect(result, isA<Success<ProfileResponseModel>>());
      expect((result as Success<ProfileResponseModel>).data, response);
    });

    test('returns Error when a DioException is thrown', () async {
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/auth/upload-photo'),
        type: DioExceptionType.unknown,
      );
      when(() => apiClient.uploadPhoto(any())).thenThrow(dioException);

      final result = await dataSource.uploadPhoto(_FakeFile());

      expect(result, isA<Error<ProfileResponseModel>>());
    });
  });
}
