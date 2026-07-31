import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/exercises/domain/entities/levels_entity.dart';
import 'package:flowery/features/exercises/domain/repo/exercise_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class LevelsUseCase {
  final ExerciseRepoContract exerciseRepo;
  LevelsUseCase(this.exerciseRepo);
  Future<Result<LevelsEntity>> call(String muscleId) {
    return exerciseRepo.getDifficultyLevelsByPrimeMover(muscleId);
  }
}
