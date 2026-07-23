sealed class ExerciseEvents {}

class LoadExerciseLevelsEvent extends ExerciseEvents {
  final String muscleId;
  LoadExerciseLevelsEvent({required this.muscleId});
}

class SelectDifficultyLevelEvent extends ExerciseEvents {
  final String newLevelId;
  final String oldLevelId;
  SelectDifficultyLevelEvent({
    required this.newLevelId,
    required this.oldLevelId,
  });
}
class ToggleExerciseVideoEvent extends ExerciseEvents {
  final String exerciseId;
  ToggleExerciseVideoEvent({required this.exerciseId});
}