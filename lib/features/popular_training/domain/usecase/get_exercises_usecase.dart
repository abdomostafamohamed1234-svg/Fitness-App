import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/popular_training/domain/repository/popular_training_repository_contract.dart';
import 'package:injectable/injectable.dart';

import '../entities/exercise_entity.dart';

@injectable
class GetPopularTrainingUseCase {
  final PopularTrainingRepository repository;

  const GetPopularTrainingUseCase(this.repository);

  Future<Result<List<ExerciseEntity>>> call() {
    return repository.getPopularTrainingExercises();
  }
}