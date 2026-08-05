import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/exercises/domain/entities/exercises_entity.dart';
import 'package:flowery/features/exercises/domain/repo/exercise_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class ExerciseUseCase {
  final ExerciseRepoContract exerciseRepo;
  ExerciseUseCase(this.exerciseRepo);
  Future<Result<ExercisesEntity>> call(
    String muscleId,
    String difficultyLevelId,
  ) {
    return exerciseRepo.getExercisesByMuscleDifficulty(
      muscleId,
      difficultyLevelId,
    );
  }
}
