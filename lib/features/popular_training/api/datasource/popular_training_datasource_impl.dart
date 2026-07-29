import 'dart:math';
import 'package:flowery/features/popular_training/api/api_client/popular_training_api_client.dart';
import 'package:flowery/features/popular_training/data/models/exercise_model_reponse.dart';
import 'package:injectable/injectable.dart';

abstract class PopularTrainingRemoteDataSource {
  Future<List<ExerciseModel>> getPopularTrainingExercises();
}

@Injectable(as: PopularTrainingRemoteDataSource)
class PopularTrainingRemoteDataSourceImpl
    implements PopularTrainingRemoteDataSource {
  final PopularTrainingApiClient apiClient;
  final Random _random;

  PopularTrainingRemoteDataSourceImpl(this.apiClient) : _random = Random();

  @override
  Future<List<ExerciseModel>> getPopularTrainingExercises() async {
    // 1) /levels -> pick one random level (id1)
    final levelsResponse = await apiClient.getLevels();
    final levels = levelsResponse.levels;
    final randomLevel = levels[_random.nextInt(levels.length)];

    final musclesResponse = await apiClient.getRandomPrimeMoverMuscles();
    final muscles = musclesResponse.muscles;
    final randomMuscle = muscles[_random.nextInt(muscles.length)];

    final exercisesResponse = await apiClient.getExercises(
      primeMoverMuscleId: randomMuscle.id,
      difficultyLevelId: randomLevel.id,
    );
    return exercisesResponse.exercises
        .map((exercise) => exercise.copyWithMuscleImage(randomMuscle.image))
        .toList();
  }
}