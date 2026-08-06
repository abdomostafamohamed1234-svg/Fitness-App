import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/home/api/api_client/home_api_client.dart';
import 'package:flowery/features/home/api/datasourse/home_remote_datasourse_impl.dart';
import 'package:flowery/features/home/data/models/food_for_you_response_dto.dart';
import 'package:flowery/features/home/data/models/profile_response_dto.dart';
import 'package:flowery/features/home/data/models/recommendation_to_day_response_dto.dart';
import 'package:flowery/features/home/data/models/work_out_response_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_remote_datasourse_impl_test.mocks.dart';

@GenerateMocks([
  HomeApiClient,
  FoodForYouResponseDto,
  WorkOutResponseDto,
  RecommendationToDayResponseDto,
  ProfileResponseDto,
])
void main() {
  late MockHomeApiClient mockApiClient;
  late HomeRemoteDataSourceImpl dataSource;

  setUp(() {
    mockApiClient = MockHomeApiClient();
    dataSource = HomeRemoteDataSourceImpl(mockApiClient);
  });

  group('getFoodData', () {
    test('returns Success with the DTO when api call succeeds', () async {
      final dto = MockFoodForYouResponseDto();
      when(mockApiClient.getFoodData()).thenAnswer((_) async => dto);

      final result = await dataSource.getFoodData();

      expect(result, isA<Success<FoodForYouResponseDto>>());
      expect((result as Success).data, dto);
    });

    test('returns Error when api call throws', () async {
      final exception = Exception('server error');
      when(mockApiClient.getFoodData()).thenThrow(exception);

      final result = await dataSource.getFoodData();

      expect(result, isA<Error<FoodForYouResponseDto>>());
      expect((result as Error).exception, exception);
    });
  });

  group('getWorkOutData', () {
    test('returns Success with the DTO when api call succeeds', () async {
      final dto = MockWorkOutResponseDto();
      when(mockApiClient.getWorkOutData()).thenAnswer((_) async => dto);

      final result = await dataSource.getWorkOutData();

      expect(result, isA<Success<WorkOutResponseDto>>());
      expect((result as Success).data, dto);
    });

    test('returns Error when api call throws', () async {
      final exception = Exception('server error');
      when(mockApiClient.getWorkOutData()).thenThrow(exception);

      final result = await dataSource.getWorkOutData();

      expect(result, isA<Error<WorkOutResponseDto>>());
      expect((result as Error).exception, exception);
    });
  });

  group('getRecommendationData', () {
    test('returns Success with the DTO when api call succeeds', () async {
      final dto = MockRecommendationToDayResponseDto();
      when(mockApiClient.getRecommendationData())
          .thenAnswer((_) async => dto);

      final result = await dataSource.getRecommendationData();

      expect(result, isA<Success<RecommendationToDayResponseDto>>());
      expect((result as Success).data, dto);
    });

    test('returns Error when api call throws', () async {
      final exception = Exception('server error');
      when(mockApiClient.getRecommendationData()).thenThrow(exception);

      final result = await dataSource.getRecommendationData();

      expect(result, isA<Error<RecommendationToDayResponseDto>>());
      expect((result as Error).exception, exception);
    });
  });

  group('getProfileData', () {
    test('returns Success with the DTO when api call succeeds', () async {
      final dto = MockProfileResponseDto();
      when(mockApiClient.getProfileData()).thenAnswer((_) async => dto);

      final result = await dataSource.getProfileData();

      expect(result, isA<Success<ProfileResponseDto>>());
      expect((result as Success).data, dto);
    });

    test('returns Error when api call throws', () async {
      final exception = Exception('server error');
      when(mockApiClient.getProfileData()).thenThrow(exception);

      final result = await dataSource.getProfileData();

      expect(result, isA<Error<ProfileResponseDto>>());
      expect((result as Error).exception, exception);
    });
  });
}