import 'dart:math';


import 'package:flowery/features/popular_training/api/api_client/popular_training_api_client.dart';
import 'package:flowery/features/popular_training/data/models/exercise_model_reponse.dart';
import 'package:injectable/injectable.dart';

/// Contract: isolated from Dio/Retrofit details so the repository only
/// depends on this abstraction.
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

    // 2) /muscles/random -> already a random list, pick one (id2 + image)
    final musclesResponse = await apiClient.getRandomPrimeMoverMuscles();
    final muscles = musclesResponse.muscles;
    final randomMuscle = muscles[_random.nextInt(muscles.length)];

    // 3) /exercises/by-muscle-difficulty(primeMoverMuscleId, difficultyLevelId)
    final exercisesResponse = await apiClient.getExercises(
      primeMoverMuscleId: randomMuscle.id,
      difficultyLevelId: randomLevel.id,
    );

    // The exercises endpoint has no image field, so we attach the muscle
    // image (from step 2) to every exercise in this batch.
    return exercisesResponse.exercises
        .map((exercise) => exercise.copyWithMuscleImage(randomMuscle.image))
        .toList();
  }
}