import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/workouts/data/models/muscle_group_by_id_response.dart';
import 'package:flowery/features/workouts/data/models/muscle_group_model.dart';

abstract class WorkoutRemoteDataSourceContract {
  Future<Result<List<MuscleGroupModel>>> fetchWorkouts();

  Future<Result<MuscleGroupByIdResponse>> getMusclesByGroupId(
    String muscleGroupId,
  );
}