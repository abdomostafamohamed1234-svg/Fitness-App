import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/popular_training/api/datasource/popular_training_datasource_impl.dart';
import 'package:flowery/features/popular_training/domain/entities/exercise_entity.dart';
import 'package:flowery/features/popular_training/domain/repository/popular_training_repository_contract.dart';
import 'package:injectable/injectable.dart';



@Injectable(as: PopularTrainingRepository)
class PopularTrainingRepositoryImpl implements PopularTrainingRepository {
  final PopularTrainingRemoteDataSource remoteDataSource;

  const PopularTrainingRepositoryImpl(this.remoteDataSource);

  @override
  Future<Result<List<ExerciseEntity>>> getPopularTrainingExercises() async {
    try {
      final exercises = await remoteDataSource.getPopularTrainingExercises();
      return Success<List<ExerciseEntity>>(data: exercises);
    } on Exception catch (e) {
      return Error<List<ExerciseEntity>>(exception: e);
    }
  }
}