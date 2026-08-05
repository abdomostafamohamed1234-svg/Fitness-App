// import 'package:flowery/core/base/base_response.dart';
// import 'package:flowery/features/home/data/models/food_for_you_response_dto.dart';
// import 'package:flowery/features/home/data/models/recommendation_to_day_response_dto.dart';
// import 'package:flowery/features/home/data/models/work_out_response_dto.dart';
// import 'package:flowery/features/home/data/datasourse/home_remote_datasourse_contract.dart';
// import 'package:flowery/features/home/data/repository/home_repository_impl.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';

// import 'home_repository_impl_test.mocks.dart';

// @GenerateMocks([
//   HomeRemoteDataSourceContract,
//   FoodForYouResponseDto,
//   WorkOutResponseDto,
//   RecommendationToDayResponseDto,
// ])
// void main() {
//   late MockHomeRemoteDataSourceContract mockDataSource;
//   late HomeRepositoryImpl repository;

//   final testException = Exception('network error');

//   setUp(() {
//     mockDataSource = MockHomeRemoteDataSourceContract();
//     repository = HomeRepositoryImpl(mockDataSource);
//   });

//   group('getFoodData', () {
//     test('maps DTO to entity on success', () async {
//       final dto = MockFoodForYouResponseDto();
//       when(dto.categories).thenReturn(const []);
//       when(mockDataSource.getFoodData())
//           .thenAnswer((_) async => Success(data: dto));

//       final result = await repository.getFoodData();

//       expect(result, isA<Success>());
//       final data = (result as Success).data;
//       expect(data!.categories, isEmpty);
//       verify(mockDataSource.getFoodData()).called(1);
//     });

//     test('propagates the exception on error', () async {
//       when(mockDataSource.getFoodData())
//           .thenAnswer((_) async => Error(exception: testException));

//       final result = await repository.getFoodData();

//       expect(result, isA<Error>());
//       expect((result as Error).exception, testException);
//     });
//   });

//   group('getWorkOutData', () {
//     test('maps DTO to entity on success', () async {
//       final dto = MockWorkOutResponseDto();
//       when(dto.message).thenReturn('welcome');
//       when(dto.musclesGroup).thenReturn(const []);
//       when(mockDataSource.getWorkOutData())
//           .thenAnswer((_) async => Success(data: dto));

//       final result = await repository.getWorkOutData();

//       expect(result, isA<Success>());
//       final data = (result as Success).data;
//       expect(data!.message, 'welcome');
//       expect(data.musclesGroup, isEmpty);
//     });

//     test('propagates the exception on error', () async {
//       when(mockDataSource.getWorkOutData())
//           .thenAnswer((_) async => Error(exception: testException));

//       final result = await repository.getWorkOutData();

//       expect(result, isA<Error>());
//       expect((result as Error).exception, testException);
//     });
//   });

//   group('getRecommendationData', () {
//     test('maps DTO to entity on success', () async {
//       final dto = MockRecommendationToDayResponseDto();
//       when(dto.message).thenReturn('todays picks');
//       when(dto.totalMuscles).thenReturn(3);
//       when(dto.muscles).thenReturn(const []);
//       when(mockDataSource.getRecommendationData())
//           .thenAnswer((_) async => Success(data: dto));

//       final result = await repository.getRecommendationData();

//       expect(result, isA<Success>());
//       final data = (result as Success).data;
//       expect(data!.message, 'todays picks');
//       expect(data.totalMuscles, 3);
//       expect(data.muscles, isEmpty);
//     });

//     test('propagates the exception on error', () async {
//       when(mockDataSource.getRecommendationData())
//           .thenAnswer((_) async => Error(exception: testException));

//       final result = await repository.getRecommendationData();

//       expect(result, isA<Error>());
//       expect((result as Error).exception, testException);
//     });
//   });

//   // ---- getProfileData ----
//   // TODO: needs `profile_response_dto.dart` to know the type of the nested
//   // `user` field so a mock/stub can be built for it. The error-path test
//   // below works already; the success-path test will be added once that
//   // file is available.
//   group('getProfileData', () {
//     test('propagates the exception on error', () async {
//       when(mockDataSource.getProfileData())
//           .thenAnswer((_) async => Error(exception: testException));

//       final result = await repository.getProfileData();

//       expect(result, isA<Error>());
//       expect((result as Error).exception, testException);
//     });
//   });
// }