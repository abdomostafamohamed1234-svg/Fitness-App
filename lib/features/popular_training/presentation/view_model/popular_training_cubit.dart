import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/popular_training/domain/usecase/get_exercises_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/exercise_entity.dart';
import 'popular_training_state.dart';

/// NOTE: this is a Cubit, not a Bloc, so there is no separate "Event" class.
/// The public method below (getPopularTraining) is the single "event" /
/// trigger that causes a state transition. If you actually need a Bloc with
/// explicit Event classes instead, let me know and I'll convert it.
@injectable
class PopularTrainingCubit extends Cubit<PopularTrainingState> {
  final GetPopularTrainingUseCase getPopularTrainingUseCase;

  PopularTrainingCubit(this.getPopularTrainingUseCase)
    : super(const PopularTrainingInitial());

  Future<void> getPopularTraining() async {
    emit(const PopularTrainingLoading());

    final result = await getPopularTrainingUseCase();

    switch (result) {
      case Success<List<ExerciseEntity>>(:final data):
        emit(PopularTrainingSuccess(data ?? const []));
      case Error<List<ExerciseEntity>>(:final exception):
        emit(PopularTrainingError(exception ?? Exception('unexpected problem')));
    }
  }
}