import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/exercises/data/models/exercises_response.dart';
import 'package:flowery/features/exercises/data/models/levels_response.dart';

abstract interface class ExerciseDataSourceContract {
  Future<Result<ExercisesResponse>> getExercisesByMuscleDifficulty(
    String muscleId,
    String difficultyLevelId,
  );
  Future<Result<LevelsResponse>> getDifficultyLevelsByPrimeMover(
    String muscleId,
  );
}