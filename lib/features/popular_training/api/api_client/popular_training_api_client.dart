import 'package:dio/dio.dart';
import 'package:flowery/config/api/api_endpoints.dart';
import 'package:flowery/features/popular_training/data/models/exercise_model_reponse.dart';
import 'package:flowery/features/popular_training/data/models/level_model_response.dart';
import 'package:flowery/features/popular_training/data/models/muscle_model_response.dart';

import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'popular_training_api_client.g.dart';

@injectable
@RestApi()
abstract class PopularTrainingApiClient {
  @factoryMethod
  factory PopularTrainingApiClient(Dio dio) = _PopularTrainingApiClient;

  @GET(AppEndPoints.recommendationToDay)
  Future<MusclesResponse> getRandomPrimeMoverMuscles();

  @GET(AppEndPoints.levels)
  Future<LevelsResponse> getLevels();

  @GET(AppEndPoints.getExercisesByPrimeMoverMuscleAndDifficultyLevel)
  Future<ExercisesResponse> getExercises({
    @Query('primeMoverMuscleId') required String primeMoverMuscleId,
    @Query('difficultyLevelId') required String difficultyLevelId,
  });
}