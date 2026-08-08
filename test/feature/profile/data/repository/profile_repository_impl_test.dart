import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/feature/profile/api/api/profile_api_client.dart';
import 'package:flowery/feature/profile/data/models/profile_response_model.dart';
import 'package:flowery/feature/profile/domain/entities/profile_entity.dart';
import 'package:flowery/feature/profile/data/repository/profile_repository_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([ProfileApiClient, ProfileResponseModel])
import 'profile_repository_impl_test.mocks.dart';

void main() {
  late MockProfileApiClient mockApiClient;
  late ProfileRepositoryImpl repository;

  setUp(() {
    mockApiClient = MockProfileApiClient();
    repository = ProfileRepositoryImpl(mockApiClient);
  });

  group('getProfile', () {
    test('لازم يرجع Success مع الـ ProfileEntity الناتجة من toEntity()', () async {
      // Arrange
      final mockResponseModel = MockProfileResponseModel();
      // ⚠️ عدّلي الـ constructor على حسب فيلدز ProfileEntity الحقيقية
      final fakeEntity = const ProfileEntity(id: '', firstName: '', lastName: '', email: '');

      when(mockApiClient.getProfile())
          .thenAnswer((_) async => mockResponseModel);
      when(mockResponseModel.toEntity()).thenReturn(fakeEntity);

      // Act
      final result = await repository.getProfile();

      // Assert
      expect(result, isA<Success<ProfileEntity>>());
      expect((result as Success<ProfileEntity>).data, fakeEntity);
      verify(mockApiClient.getProfile()).called(1);
      verify(mockResponseModel.toEntity()).called(1);
    });

    test('لازم يرجع Error لما يحصل DioException', () async {
      // Arrange
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/profile'),
        type: DioExceptionType.connectionTimeout,
      );

      when(mockApiClient.getProfile()).thenThrow(dioException);

      // Act
      final result = await repository.getProfile();

      // Assert
      expect(result, isA<Error<ProfileEntity>>());
      final error = result as Error<ProfileEntity>;
      expect(error.exception, isA<DioException>());
    });

    test('لازم يرجع Error لما يحصل استثناء عادي (Exception)', () async {
      // Arrange
      when(mockApiClient.getProfile()).thenThrow(Exception('Unknown error'));

      // Act
      final result = await repository.getProfile();

      // Assert
      expect(result, isA<Error<ProfileEntity>>());
    });

    test('لازم يرجع Error ويلف الاستثناء غير الـ Exception جوه Exception', () async {
      // Arrange: حالة استثناء مش من نوع Exception (زي String أو Error عادية)
      when(mockApiClient.getProfile()).thenThrow('some raw error');

      // Act
      final result = await repository.getProfile();

      // Assert
      expect(result, isA<Error<ProfileEntity>>());
      final error = result as Error<ProfileEntity>;
      expect(error.exception, isA<Exception>());
    });
  });
}