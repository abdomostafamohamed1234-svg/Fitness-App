import 'package:dio/dio.dart';
import 'package:flowery/config/api/api_endpoints.dart';
import 'package:flowery/features/exercises/data/models/exercises_response.dart';
import 'package:flowery/features/exercises/data/models/levels_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
part 'exercise_api_client.g.dart';

@injectable
@RestApi()
abstract class ExerciseApiClient {
  @factoryMethod
  factory ExerciseApiClient(Dio dio) = _ExerciseApiClient;
  @GET(AppEndPoints.exercisesByMuscleDifficulty)
  Future<ExercisesResponse> getExercisesByMuscleDifficulty(
    @Query("primeMoverMuscleId") String muscleId,
    @Query("difficultyLevelId") String difficultyLevelId,
  );
  @GET(AppEndPoints.difficultyLevelsByPrimeMover)
  Future<LevelsResponse> getDifficultyLevelsByPrimeMover(
    @Query("primeMoverMuscleId") String muscleId,
  );
}
