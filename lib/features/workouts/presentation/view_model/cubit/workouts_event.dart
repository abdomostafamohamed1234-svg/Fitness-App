sealed class WorkoutsEvent {}

class GetMuscleGroupsIntent extends WorkoutsEvent {}

class GetWorkoutsByGroupIntent extends WorkoutsEvent {
  final String muscleGroupId;
  GetWorkoutsByGroupIntent(this.muscleGroupId);
}