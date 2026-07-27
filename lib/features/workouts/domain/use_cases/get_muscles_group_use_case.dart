// import 'package:fitness_app/config/base_response/base_response.dart';
// import 'package:fitness_app/features/workouts/domain/entities/muscle_group_entity.dart';
// import 'package:fitness_app/features/workouts/domain/repositories/workouts_repository.dart';
// import 'package:flowery/features/workouts/domain/entities/muscle_group_entity.dart';
// import 'package:flowery/features/workouts/domain/repositories/workouts_repository.dart';
// import 'package:injectable/injectable.dart';

// @injectable
// class GetMusclesGroupUseCase {
//   final WorkoutRepository _workoutRepository;

//   GetMusclesGroupUseCase(this._workoutRepository);

//   Future<BaseResponse<List<MuscleGroupEntity>>> invoke() {
//     return _workoutRepository.getAllMuscleGroups();
//   }
// }


import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/workouts/domain/entities/muscle_group_entity.dart';
import 'package:flowery/features/workouts/domain/repositories/workouts_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetMusclesGroupUseCase {
  final WorkoutRepository _workoutRepository;

  GetMusclesGroupUseCase(this._workoutRepository);

  Future<Result<List<MuscleGroupEntity>>> invoke() {
    return _workoutRepository.getAllMuscleGroups();
  }
}