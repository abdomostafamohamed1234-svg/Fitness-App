import 'dart:developer';
import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/core/base/base_state.dart';
import 'package:flowery/features/workouts/domain/entities/muscle_group_by_id_response_entity.dart';
import 'package:flowery/features/workouts/domain/entities/muscle_group_entity.dart';
import 'package:flowery/features/workouts/domain/use_cases/get_muscles_group_by_id_use_case.dart';
import 'package:flowery/features/workouts/domain/use_cases/get_muscles_group_use_case.dart';
import 'package:flowery/features/workouts/presentation/view_model/cubit/workouts_event.dart';
import 'package:flowery/features/workouts/presentation/view_model/cubit/workouts_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class WorkoutsCubit extends Cubit<WorkoutsState> {
  final GetMusclesGroupUseCase _getMusclesGroupUseCase;
  final GetMusclesGroupByIdUseCase _getMusclesGroupByIdUseCase;

  WorkoutsCubit(
    this._getMusclesGroupUseCase,
    this._getMusclesGroupByIdUseCase,
  ) : super(WorkoutsState(
          muscleGroupsState: const BaseState.loading(),
          workoutsState: const BaseState.loading(),
        ));

  // ================== EVENTS ==================

  void doEvent(WorkoutsEvent event) {
    switch (event) {
      case GetMuscleGroupsIntent():
        _fetchMuscleGroups();
      case GetWorkoutsByGroupIntent():
        _fetchWorkoutsByGroup(event.muscleGroupId);
    }
  }

  // ================== MUSCLE GROUPS ==================

  Future<void> _fetchMuscleGroups() async {
    emit(state.copyWith(muscleGroupsState: const BaseState.loading()));

    final Result<List<MuscleGroupEntity>> response =
        await _getMusclesGroupUseCase.invoke();

    switch (response) {
      case Success(:final data):
        emit(state.copyWith(muscleGroupsState: BaseState.success(data)));
        if (data!.isNotEmpty) {
          doEvent(GetWorkoutsByGroupIntent(data.first.id!));
        }
      case Error(:final exception):
        log(exception.toString());
        emit(state.copyWith(muscleGroupsState: BaseState.error(exception)));
    }
  }

  // ================== WORKOUTS BY GROUP ==================

  Future<void> _fetchWorkoutsByGroup(String groupId) async {
    emit(state.copyWith(
      workoutsState: const BaseState.loading(),
      selectedGroupId: groupId,
    ));

    final Result<MuscleGroupByIdResponseEntity> response =
        await _getMusclesGroupByIdUseCase.call(groupId);

    switch (response) {
      case Success(:final data):
        emit(state.copyWith(workoutsState: BaseState.success(data)));
      case Error(:final exception):
        log(exception.toString());
        emit(state.copyWith(workoutsState: BaseState.error(exception)));
    }
  }

  @override
  void emit(WorkoutsState state) {
    if (isClosed) return;
    super.emit(state);
  }
}