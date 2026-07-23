import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/exercises/domain/entities/exercises_entity.dart';
import 'package:flowery/features/exercises/domain/entities/levels_entity.dart';

abstract interface class ExerciseRepoContract {
  Future<Result<ExercisesEntity>> getExercisesByMuscleDifficulty(
    String muscleId,
    String difficultyLevelId,
  );
  Future<Result<LevelsEntity>> getDifficultyLevelsByPrimeMover(
    String muscleId,
  );
}