
// import 'package:flowery/features/workouts/data/datasources/workouts_remote_data_source_contract.dart';
// import 'package:flowery/features/workouts/domain/entities/muscle_group_by_id_response_entity.dart';
// import 'package:flowery/features/workouts/domain/entities/muscle_group_entity.dart';
// import 'package:flowery/features/workouts/domain/repositories/workouts_repository.dart';
// import 'package:injectable/injectable.dart';

// @Injectable(as: WorkoutRepository)
// class WorkoutsRepositoryImpl implements WorkoutRepository {
//   final WorkoutRemoteDataSourceContract _remoteDataSource;

//   WorkoutsRepositoryImpl(this._remoteDataSource);
  
//   @override
//   Future<BaseResponse<List<MuscleGroupEntity>>> getAllMuscleGroups() async {
//     return await _remoteDataSource.fetchWorkouts();
//   }

//   @override
//   Future<BaseResponse<MuscleGroupByIdResponseEntity>> getMusclesByGroupId(
//     String muscleGroupId,
//   ) async {
//     return await _remoteDataSource.getMusclesByGroupId(muscleGroupId);
//   }
// }


import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/workouts/data/datasources/workouts_remote_data_source_contract.dart';
import 'package:flowery/features/workouts/domain/entities/muscle_group_by_id_response_entity.dart';
import 'package:flowery/features/workouts/domain/entities/muscle_group_entity.dart';
import 'package:flowery/features/workouts/domain/repositories/workouts_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: WorkoutRepository)
class WorkoutsRepositoryImpl implements WorkoutRepository {
  final WorkoutRemoteDataSourceContract _remoteDataSource;

  WorkoutsRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<List<MuscleGroupEntity>>> getAllMuscleGroups() async {
    return await _remoteDataSource.fetchWorkouts();
  }

  @override
  Future<Result<MuscleGroupByIdResponseEntity>> getMusclesByGroupId(
    String muscleGroupId,
  ) async {
    return await _remoteDataSource.getMusclesByGroupId(muscleGroupId);
  }
}