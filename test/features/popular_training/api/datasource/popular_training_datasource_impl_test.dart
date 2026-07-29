import 'package:flowery/features/popular_training/api/api_client/popular_training_api_client.dart';
import 'package:flowery/features/popular_training/api/datasource/popular_training_datasource_impl.dart';
import 'package:flowery/features/popular_training/data/models/exercise_model_reponse.dart';
import 'package:flowery/features/popular_training/data/models/level_model_response.dart';
import 'package:flowery/features/popular_training/data/models/muscle_model_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_training_datasource_impl_test.mocks.dart';

// Run: flutter pub run build_runner build --delete-conflicting-outputs
@GenerateMocks([PopularTrainingApiClient])
void main() {
  late MockPopularTrainingApiClient mockApiClient;
  late PopularTrainingRemoteDataSourceImpl dataSource;

  setUp(() {
    mockApiClient = MockPopularTrainingApiClient();
    dataSource = PopularTrainingRemoteDataSourceImpl(mockApiClient);
  });

  // Single-item lists are used everywhere so the internal `Random` pick is
  // deterministic - there is only one item it *could* pick.
  const level = LevelModel(id: 'level-1', name: 'Beginner');
  const muscle = MuscleModel(
    id: 'muscle-1',
    name: 'Biceps',
    image: 'https://example.com/biceps.png',
  );
  const exercise = ExerciseModel(
    idJson: 'ex-1',
    nameJson: 'Curl',
    difficultyLevelJson: 'level-1',
    targetMuscleGroupJson: 'Arms',
    primeMoverMuscleJson: 'muscle-1',
  );

  const levelsResponse = LevelsResponse(message: 'ok', levels: [level]);
  const musclesResponse = MusclesResponse(
    message: 'ok',
    totalMuscles: 1,
    muscles: [muscle],
  );
  const exercisesResponse = ExercisesResponse(
    message: 'ok',
    totalExercises: 1,
    totalPages: 1,
    currentPage: 1,
    exercises: [exercise],
  );

  group('getPopularTrainingExercises', () {
    test(
      'fetches levels, muscles and exercises, then attaches the muscle '
      'image to every returned exercise',
      () async {
        when(mockApiClient.getLevels()).thenAnswer((_) async => levelsResponse);
        when(
          mockApiClient.getRandomPrimeMoverMuscles(),
        ).thenAnswer((_) async => musclesResponse);
        when(
          mockApiClient.getExercises(
            primeMoverMuscleId: anyNamed('primeMoverMuscleId'),
            difficultyLevelId: anyNamed('difficultyLevelId'),
          ),
        ).thenAnswer((_) async => exercisesResponse);

        final result = await dataSource.getPopularTrainingExercises();

        expect(result, hasLength(1));
        expect(result.first.idJson, exercise.idJson);
        expect(result.first.muscleImageJson, muscle.image);

        verify(mockApiClient.getLevels()).called(1);
        verify(mockApiClient.getRandomPrimeMoverMuscles()).called(1);
        verify(
          mockApiClient.getExercises(
            primeMoverMuscleId: muscle.id,
            difficultyLevelId: level.id,
          ),
        ).called(1);
      },
    );

    test('propagates exceptions thrown by the api client', () async {
      when(mockApiClient.getLevels()).thenThrow(Exception('network error'));

      expect(
        () => dataSource.getPopularTrainingExercises(),
        throwsA(isA<Exception>()),
      );
    });

    test('returns an empty list when the exercises response is empty', () async {
      when(mockApiClient.getLevels()).thenAnswer((_) async => levelsResponse);
      when(
        mockApiClient.getRandomPrimeMoverMuscles(),
      ).thenAnswer((_) async => musclesResponse);
      when(
        mockApiClient.getExercises(
          primeMoverMuscleId: anyNamed('primeMoverMuscleId'),
          difficultyLevelId: anyNamed('difficultyLevelId'),
        ),
      ).thenAnswer(
        (_) async => const ExercisesResponse(
          message: 'ok',
          totalExercises: 0,
          totalPages: 0,
          currentPage: 1,
          exercises: [],
        ),
      );

      final result = await dataSource.getPopularTrainingExercises();

      expect(result, isEmpty);
    });
  });
}