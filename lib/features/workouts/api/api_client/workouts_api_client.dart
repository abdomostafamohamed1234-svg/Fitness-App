import 'package:dio/dio.dart';
import 'package:flowery/config/api/api_endpoints.dart';
import 'package:flowery/features/workouts/data/models/muscle_group_by_id_response.dart';
import 'package:flowery/features/workouts/data/models/muscles_group_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'workouts_api_client.g.dart';

@RestApi(baseUrl: AppEndPoints.baseUrl)
@lazySingleton
abstract class WorkoutsApiClient {
  @factoryMethod
  factory WorkoutsApiClient(Dio dio) = _WorkoutsApiClient;

  @GET(AppEndPoints.upcomingWorkOut)
  Future<MusclesGroupResponse> getAllMuscleGroups();

  @GET('${AppEndPoints.musclesByGroup}/{id}')
  Future<MuscleGroupByIdResponse> getMusclesByGroupId(
    @Path('id') String? muscleGroupId,
  );
}
