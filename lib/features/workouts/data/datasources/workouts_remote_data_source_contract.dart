// import 'package:fitness_app/config/base_response/base_response.dart';
// import 'package:fitness_app/features/workouts/data/models/muscle_group_by_id_response.dart';
// import 'package:fitness_app/features/workouts/data/models/muscle_group_model.dart';
// import 'package:flowery/features/home/domian/entities/work_out_model.dart';
// import 'package:flowery/features/workouts/data/models/muscle_group_by_id_response.dart';

// abstract class WorkoutRemoteDataSourceContract {
//   Future<BaseResponse<List<MuscleGroupModel>>> fetchWorkouts();

//   Future<BaseResponse<MuscleGroupByIdResponse>> getMusclesByGroupId(
//     String muscleGroupId,
//   );
// }

import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/workouts/data/models/muscle_group_by_id_response.dart';
import 'package:flowery/features/workouts/data/models/muscle_group_model.dart';

abstract class WorkoutRemoteDataSourceContract {
  Future<Result<List<MuscleGroupModel>>> fetchWorkouts();

  Future<Result<MuscleGroupByIdResponse>> getMusclesByGroupId(
    String muscleGroupId,
  );
}