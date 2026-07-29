import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/popular_training/api/datasource/popular_training_datasource_impl.dart';
import 'package:flowery/features/popular_training/data/models/exercise_model_reponse.dart';
import 'package:flowery/features/popular_training/domain/entities/exercise_entity.dart';
import 'package:flowery/features/popular_training/data/repository/popular_training_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_training_repository_impl_test.mocks.dart';

// Run: flutter pub run build_runner build --delete-conflicting-outputs
@GenerateMocks([PopularTrainingRemoteDataSource])
void main() {
  late MockPopularTrainingRemoteDataSource mockRemoteDataSource;
  late PopularTrainingRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockPopularTrainingRemoteDataSource();
    repository = PopularTrainingRepositoryImpl(mockRemoteDataSource);
  });

  const exercise = ExerciseModel(
    idJson: 'ex-1',
    nameJson: 'Curl',
    difficultyLevelJson: 'level-1',
    targetMuscleGroupJson: 'Arms',
    primeMoverMuscleJson: 'muscle-1',
  );

  group('getPopularTrainingExercises', () {
    test(
      'returns Success with the exercises when the data source succeeds',
      () async {
        when(
          mockRemoteDataSource.getPopularTrainingExercises(),
        ).thenAnswer((_) async => [exercise]);

        final result = await repository.getPopularTrainingExercises();

        expect(result, isA<Success<List<ExerciseEntity>>>());
        final data = (result as Success<List<ExerciseEntity>>).data;
        expect(data, hasLength(1));
        expect(data!.first.id, exercise.id);
        verify(mockRemoteDataSource.getPopularTrainingExercises()).called(1);
      },
    );

    test(
      'returns Error carrying the exception when the data source throws',
      () async {
        final exception = Exception('network error');
        when(
          mockRemoteDataSource.getPopularTrainingExercises(),
        ).thenThrow(exception);

        final result = await repository.getPopularTrainingExercises();

        expect(result, isA<Error<List<ExerciseEntity>>>());
        expect((result as Error<List<ExerciseEntity>>).exception, exception);
      },
    );
  });
}