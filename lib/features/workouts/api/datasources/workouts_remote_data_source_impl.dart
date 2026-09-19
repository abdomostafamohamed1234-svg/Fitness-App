import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/workouts/api/api_client/workouts_api_client.dart';
import 'package:flowery/features/workouts/data/datasources/workouts_remote_data_source_contract.dart';
import 'package:flowery/features/workouts/data/models/muscle_group_by_id_response.dart';
import 'package:flowery/features/workouts/data/models/muscle_group_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: WorkoutRemoteDataSourceContract)
class WorkoutsRemoteDataSourceImpl implements WorkoutRemoteDataSourceContract {
  final WorkoutsApiClient _client;

  WorkoutsRemoteDataSourceImpl(this._client);

  @override
  Future<Result<List<MuscleGroupModel>>> fetchWorkouts() async {
    try {
      final response = await _client.getAllMuscleGroups();
      return Success(data: response.musclesGroup ?? []);
    } catch (e) {
      return Error(exception: e is Exception ? e : Exception(e.toString()));
    }
  }

  @override
  Future<Result<MuscleGroupByIdResponse>> getMusclesByGroupId(
    String muscleGroupId,
  ) async {
    try {
      final response = await _client.getMusclesByGroupId(muscleGroupId);
      return Success(data: response);
    } catch (e) {
      return Error(exception: e is Exception ? e : Exception(e.toString()));
    }
  }
}