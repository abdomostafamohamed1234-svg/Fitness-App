// import 'package:flowery/features/workouts/domain/entities/muscle_group_by_id_response_entity.dart';
// import 'package:flowery/features/workouts/domain/entities/muscle_group_entity.dart';

// abstract class WorkoutRepository {
//   Future<BaseResponse<List<MuscleGroupEntity>>> getAllMuscleGroups();

//   Future<BaseResponse<MuscleGroupByIdResponseEntity>> getMusclesByGroupId(
//     String muscleGroupId,
//   );
// }


import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/workouts/domain/entities/muscle_group_by_id_response_entity.dart';
import 'package:flowery/features/workouts/domain/entities/muscle_group_entity.dart';

abstract class WorkoutRepository {
  Future<Result<List<MuscleGroupEntity>>> getAllMuscleGroups();

  Future<Result<MuscleGroupByIdResponseEntity>> getMusclesByGroupId(
    String muscleGroupId,
  );
}