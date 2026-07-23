import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/core/base/base_state.dart';
import 'package:flowery/features/exercises/domain/entities/exercises_entity.dart';
import 'package:flowery/features/exercises/domain/entities/levels_entity.dart';
import 'package:flowery/features/exercises/domain/use_case/exercise_use_case_.dart';
import 'package:flowery/features/exercises/domain/use_case/levels_use_case.dart';
import 'package:flowery/features/exercises/presentation/view_model/base_state/exercise_state.dart';
import 'package:flowery/features/exercises/presentation/view_model/events/exercise_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ExerciseCubit extends Cubit<ExerciseState> {
  final LevelsUseCase _levelsUseCase;
  final ExerciseUseCase _exerciseUseCase;

  ExerciseCubit(this._levelsUseCase, this._exerciseUseCase)
    : super(const ExerciseState());

  void doEvent(ExerciseEvents event) {
    switch (event) {
      case LoadExerciseLevelsEvent():
        _loadLevels(event);
      case SelectDifficultyLevelEvent():
        _selectLevel(event);
      case ToggleExerciseVideoEvent():
        _toggleVideo(event);
    }
  }

  void _loadLevels(LoadExerciseLevelsEvent event) async {
    emit(
      state.copyWith(
        muscleId: event.muscleId,
        levelsState: const BaseState.loading(),
      ),
    );

    final response = await _levelsUseCase.call(event.muscleId);

    switch (response) {
      case Success<LevelsEntity>():
        emit(state.copyWith(levelsState: BaseState.success(response.data)));

        final levels = response.data?.difficultyLevels;
        if (levels != null && levels.isNotEmpty) {
          final firstLevelId = levels.first.id ?? "";
          if (firstLevelId.isNotEmpty) {
            _selectLevel(
              SelectDifficultyLevelEvent(
                oldLevelId: state.selectedLevelId,
                newLevelId: firstLevelId,
              ),
            );
          }
        }
      case Error<LevelsEntity>():
        emit(state.copyWith(levelsState: BaseState.error(response.exception)));
    }
  }

  void _selectLevel(SelectDifficultyLevelEvent event) async {
    emit(
      state.copyWith(
        selectedLevelId: event.newLevelId,
        clearPlayingExerciseId: true,
      ),
    );

    if (event.newLevelId != event.oldLevelId) {
      emit(state.copyWith(exercisesState: const BaseState.loading()));

      final response = await _exerciseUseCase.call(
        state.muscleId,
        event.newLevelId,
      );

      switch (response) {
        case Success<ExercisesEntity>():
          emit(
            state.copyWith(exercisesState: BaseState.success(response.data)),
          );
        case Error<ExercisesEntity>():
          emit(
            state.copyWith(exercisesState: BaseState.error(response.exception)),
          );
      }
    }
  }

  void _toggleVideo(ToggleExerciseVideoEvent event) {
    final isSameExercisePlayingAlready =
        state.playingExerciseId == event.exerciseId;

    emit(
      state.copyWith(
        clearPlayingExerciseId: isSameExercisePlayingAlready,
        playingExerciseId: isSameExercisePlayingAlready
            ? null
            : event.exerciseId,
      ),
    );
  }
}
