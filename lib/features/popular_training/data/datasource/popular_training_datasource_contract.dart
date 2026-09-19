import 'package:flowery/features/popular_training/data/models/exercise_model_reponse.dart';
import 'package:flowery/features/popular_training/data/models/level_model_response.dart';
import 'package:flowery/features/popular_training/data/models/muscle_model_response.dart';

abstract class PopularTrainingRemoteDataSource {
  Future<LevelsResponse> getLevels();

  Future<MusclesResponse> getRandomMuscles();

  Future<ExercisesResponse> getExercises({
    required String primeMoverMuscleId,
    required String difficultyLevelId,
  });
}