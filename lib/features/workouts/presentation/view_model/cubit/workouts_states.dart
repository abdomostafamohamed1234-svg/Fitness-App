import 'package:flowery/core/base/base_state.dart';
import 'package:flowery/features/workouts/domain/entities/muscle_group_by_id_response_entity.dart';
import 'package:flowery/features/workouts/domain/entities/muscle_group_entity.dart';

class WorkoutsState {
  final BaseState<List<MuscleGroupEntity>> muscleGroupsState;
  final BaseState<MuscleGroupByIdResponseEntity> workoutsState;
  final String? selectedGroupId;

  WorkoutsState({
    required this.muscleGroupsState,
    required this.workoutsState,
    this.selectedGroupId,
  });

  WorkoutsState copyWith({
    BaseState<List<MuscleGroupEntity>>? muscleGroupsState,
    BaseState<MuscleGroupByIdResponseEntity>? workoutsState,
    String? selectedGroupId,
  }) {
    return WorkoutsState(
      muscleGroupsState: muscleGroupsState ?? this.muscleGroupsState,
      workoutsState: workoutsState ?? this.workoutsState,
      selectedGroupId: selectedGroupId ?? this.selectedGroupId,
    );
  }
}