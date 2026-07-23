import 'package:equatable/equatable.dart';
import 'package:flowery/core/base/base_state.dart';
import 'package:flowery/features/exercises/domain/entities/exercises_entity.dart';
import 'package:flowery/features/exercises/domain/entities/levels_entity.dart';

class ExerciseState extends Equatable {
  final String muscleId;
  final String muscleName;
  final String selectedLevelId;

  final String? playingExerciseId;

  final BaseState<LevelsEntity> levelsState;
  final BaseState<ExercisesEntity> exercisesState;

  const ExerciseState({
    this.muscleId = "",
    this.muscleName = "",
    this.selectedLevelId = "",
    this.playingExerciseId,
    this.levelsState = const BaseState.initial(),
    this.exercisesState = const BaseState.initial(),
  });

  ExerciseState copyWith({
    String? muscleId,
    String? muscleName,
    String? selectedLevelId,
    String? playingExerciseId,
    bool clearPlayingExerciseId = false,
    BaseState<LevelsEntity>? levelsState,
    BaseState<ExercisesEntity>? exercisesState,
  }) {
    return ExerciseState(
      muscleId: muscleId ?? this.muscleId,
      muscleName: muscleName ?? this.muscleName,
      selectedLevelId: selectedLevelId ?? this.selectedLevelId,
      playingExerciseId: clearPlayingExerciseId
          ? null
          : (playingExerciseId ?? this.playingExerciseId),
      levelsState: levelsState ?? this.levelsState,
      exercisesState: exercisesState ?? this.exercisesState,
    );
  }

  @override
  List<Object?> get props => [
    muscleId,
    muscleName,
    selectedLevelId,
    playingExerciseId,
    levelsState,
    exercisesState,
  ];
}
