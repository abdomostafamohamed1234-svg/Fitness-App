import 'package:dio/dio.dart';
import 'package:flowery/config/exception_handlers/dio_exception_handler.dart';
import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/exercises/api/api_client/exercise_api_client.dart';
import 'package:flowery/features/exercises/data/data_source/exercise_data_sourse_contract.dart';
import 'package:flowery/features/exercises/data/models/exercises_response.dart';
import 'package:flowery/features/exercises/data/models/levels_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ExerciseDataSourceContract)
class ExerciseDataSourceImpl implements ExerciseDataSourceContract {
  final ExerciseApiClient exerciseApiClient;
  ExerciseDataSourceImpl(this.exerciseApiClient);

  @override
  Future<Result<LevelsResponse>> getDifficultyLevelsByPrimeMover(
    String muscleId,
  ) async {
    try {
      final response = await exerciseApiClient.getDifficultyLevelsByPrimeMover(
        muscleId,
      );
      return Success<LevelsResponse>(data: response);
    } on DioException catch (e) {
      return Error<LevelsResponse>(
        exception: await DioExceptionHandler.handle(e),
      );
    }
  }

  @override
  Future<Result<ExercisesResponse>> getExercisesByMuscleDifficulty(
    String muscleId,
    String difficultyLevelId,
  ) async {
    try {
      final response = await exerciseApiClient.getExercisesByMuscleDifficulty(
        muscleId,
        difficultyLevelId,
      );
      return Success<ExercisesResponse>(data: response);
    } on DioException catch (e) {
      return Error<ExercisesResponse>(
        exception: await DioExceptionHandler.handle(e),
      );
    }
  }
}
