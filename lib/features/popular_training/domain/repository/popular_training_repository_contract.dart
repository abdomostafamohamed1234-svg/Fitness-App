// import 'package:fitness_app/config/base_response/base_response.dart';
// import 'package:fitness_app/features/popular_training/domain/entities/exercise_entity.dart';
// import 'package:fitness_app/features/popular_training/domain/entities/level_entity.dart';
// import 'package:fitness_app/features/popular_training/domain/entities/muscle_entity.dart';
 
// abstract class PopularTrainingRepository {
//   // Future<BaseResponse<List<LevelEntity>>> getLevels();
 
//   // Future<BaseResponse<List<MuscleEntity>>> getRandomMuscles();
 
//   Future<BaseResponse<List<ExerciseEntity>>> getExercises({
//     required String primeMoverMuscleId,
//     required String difficultyLevelId,
//   });
//}

import 'package:flowery/core/base/base_response.dart';

import '../entities/exercise_entity.dart';

abstract class PopularTrainingRepository {
  /// Runs the full flow:
  /// levels -> random level id
  /// muscles/random -> random muscle id + image
  /// exercises/by-muscle-difficulty(levelId, muscleId) -> list of exercises
  Future<Result<List<ExerciseEntity>>> getPopularTrainingExercises();
}