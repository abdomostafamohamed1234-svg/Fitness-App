import 'package:flowery/core/base/base_response.dart';

import '../entities/exercise_entity.dart';

abstract class PopularTrainingRepository {

  Future<Result<List<ExerciseEntity>>> getPopularTrainingExercises();
}