// import 'package:flowery/features/workouts/domain/entities/muscle_group_by_id_response_entity.dart';
// import 'package:flowery/features/workouts/domain/repositories/workouts_repository.dart';
// import 'package:injectable/injectable.dart';

// @injectable
// class GetMusclesGroupByIdUseCase {
//   final WorkoutRepository _workoutRepository;

//   GetMusclesGroupByIdUseCase(this._workoutRepository);

//   Future<BaseResponse<MuscleGroupByIdResponseEntity>> call(
//     String muscleGroupId,
//   ) async {
//     return await _workoutRepository.getMusclesByGroupId(muscleGroupId);
//   }
// }

import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/workouts/domain/entities/muscle_group_by_id_response_entity.dart';
import 'package:flowery/features/workouts/domain/repositories/workouts_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetMusclesGroupByIdUseCase {
  final WorkoutRepository _workoutRepository;

  GetMusclesGroupByIdUseCase(this._workoutRepository);

  Future<Result<MuscleGroupByIdResponseEntity>> call(
    String muscleGroupId,
  ) async {
    return await _workoutRepository.getMusclesByGroupId(muscleGroupId);
  }
}