import 'package:flowery/features/workouts/domain/entities/muscle_entity.dart';
import 'package:flowery/features/workouts/domain/entities/muscle_group_entity.dart';

class MuscleGroupByIdResponseEntity {
  final String? message;
  final MuscleGroupEntity? muscleGroup;
  final List<MuscleEntity>? muscles;

  MuscleGroupByIdResponseEntity({
    this.message,
    this.muscleGroup,
    this.muscles,
  });
}
