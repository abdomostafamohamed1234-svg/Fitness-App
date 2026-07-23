import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/exercises/data/data_source/exercise_data_sourse_contract.dart';
import 'package:flowery/features/exercises/data/mappers/exercises_mappers.dart';
import 'package:flowery/features/exercises/data/models/exercises_response.dart';
import 'package:flowery/features/exercises/data/models/levels_response.dart';
import 'package:flowery/features/exercises/domain/entities/exercises_entity.dart';
import 'package:flowery/features/exercises/domain/entities/levels_entity.dart';
import 'package:flowery/features/exercises/domain/repo/exercise_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ExerciseRepoContract)
class ExerciseRepoImpl implements ExerciseRepoContract {
  final ExerciseDataSourceContract exerciseDataSource;

  ExerciseRepoImpl(this.exerciseDataSource);
  @override
  Future<Result<LevelsEntity>> getDifficultyLevelsByPrimeMover(
    String muscleId,
  ) async {
    final response = await exerciseDataSource.getDifficultyLevelsByPrimeMover(
      muscleId,
    );
    switch (response) {
      case Success<LevelsResponse>():
        return Success<LevelsEntity>(data: response.data?.toDomain());
      case Error<LevelsResponse>():
        return Error<LevelsEntity>(exception: response.exception);
    }
  }

  @override
  Future<Result<ExercisesEntity>> getExercisesByMuscleDifficulty(
    String muscleId,
    String difficultyLevelId,
  ) async {
    final response = await exerciseDataSource.getExercisesByMuscleDifficulty(
      muscleId,
      difficultyLevelId,
    );
    switch (response) {
      case Success<ExercisesResponse>():
        return Success<ExercisesEntity>(data: response.data?.toDomain());
      case Error<ExercisesResponse>():
        return Error<ExercisesEntity>(exception: response.exception);
    }
  }
}
