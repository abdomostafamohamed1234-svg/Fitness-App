
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flowery/config/api/api_keys.dart';
import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/feature/logout/api/api_client/logout_api_client.dart';
import 'package:flowery/feature/logout/data/repository/logout_repository_impl.dart';

@GenerateMocks([LogoutApiClient, FlutterSecureStorage])
import 'logout_repository_impl_test.mocks.dart';

void main() {
  late MockLogoutApiClient mockApiClient;
  late MockFlutterSecureStorage mockSecureStorage;
  late LogoutRepositoryImpl repository;

  setUp(() {
    mockApiClient = MockLogoutApiClient();
    mockSecureStorage = MockFlutterSecureStorage();
    repository = LogoutRepositoryImpl(mockApiClient, mockSecureStorage);
  });

  group('logout', () {
    test('لازم يرجع Success ويمسح التوكين لما الـ API call ينجح', () async {
      // Arrange
      final fakeResponse = Response<dynamic>(
        requestOptions: RequestOptions(path: '/logout'),
        statusCode: 200,
        data: null,
      );

      when(mockApiClient.logout()).thenAnswer((_) async => fakeResponse);
      when(mockSecureStorage.delete(key: ApiKeys.token))
          .thenAnswer((_) async => Future.value());

      // Act
      final result = await repository.logout();

      // Assert
      expect(result, isA<Success<void>>());
      verify(mockApiClient.logout()).called(1);
      verify(mockSecureStorage.delete(key: ApiKeys.token)).called(1);
    });

    test('لازم يرجع Error وميمسحش التوكين لما الـ API يرمي DioException', () async {
      // Arrange
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/logout'),
        type: DioExceptionType.connectionTimeout,
      );

      when(mockApiClient.logout()).thenThrow(dioException);

      // Act
      final result = await repository.logout();

      // Assert
      expect(result, isA<Error<void>>());
      final error = result as Error<void>;
      expect(error.exception, isA<DioException>());
      verify(mockApiClient.logout()).called(1);
      verifyNever(mockSecureStorage.delete(key: anyNamed('key')));
    });

    test('لازم يرجع Error لو الـ API نجح لكن مسح التوكين فشل باستثناء عادي', () async {
      // Arrange
      final fakeResponse2 = Response<dynamic>(
        requestOptions: RequestOptions(path: '/logout'),
        statusCode: 200,
        data: null,
      );

      when(mockApiClient.logout()).thenAnswer((_) async => fakeResponse2);
      when(mockSecureStorage.delete(key: ApiKeys.token))
          .thenThrow(Exception('secure storage failure'));

      // Act
      final result = await repository.logout();

      // Assert
      expect(result, isA<Error<void>>());
    });

    test('لازم يرجع Error ويلف أي استثناء مش Exception جوه Exception', () async {
      // Arrange
      when(mockApiClient.logout()).thenThrow('raw string error');

      // Act
      final result = await repository.logout();

      // Assert
      expect(result, isA<Error<void>>());
      final error = result as Error<void>;
      expect(error.exception, isA<Exception>());
    });
  });
}