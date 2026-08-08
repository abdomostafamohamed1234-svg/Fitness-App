import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/popular_training/domain/usecase/get_exercises_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/exercise_entity.dart';
import 'popular_training_state.dart';

@injectable
class PopularTrainingCubit extends Cubit<PopularTrainingState> {
  final GetPopularTrainingUseCase getPopularTrainingUseCase;

  PopularTrainingCubit(this.getPopularTrainingUseCase)
    : super(const PopularTrainingInitial());

  Future<void> getPopularTraining() async {
    if (isClosed) return;
    emit(const PopularTrainingLoading());

    final result = await getPopularTrainingUseCase();

    // الكيوبت ممكن يتقفل وهو لسه مستني رد السيرفر (مثلاً لو الصفحة
    // اتقفلت أو الـ widget اتشال من الشجرة)، فلازم نتأكد قبل أي emit
    // بعد await.
    if (isClosed) return;

    switch (result) {
      case Success<List<ExerciseEntity>>(:final data):
        emit(PopularTrainingSuccess(data ?? const []));
      case Error<List<ExerciseEntity>>(:final exception):
        emit(PopularTrainingError(exception ?? Exception('unexpected problem')));
    }
  }

  @override
  void emit(PopularTrainingState state) {
    if (isClosed) return;
    super.emit(state);
  }
}