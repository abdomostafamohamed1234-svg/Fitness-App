
import 'package:equatable/equatable.dart';

import '../../domain/entities/exercise_entity.dart';

sealed class PopularTrainingState extends Equatable {
  const PopularTrainingState();

  @override
  List<Object?> get props => [];
}

class PopularTrainingInitial extends PopularTrainingState {
  const PopularTrainingInitial();
}

class PopularTrainingLoading extends PopularTrainingState {
  const PopularTrainingLoading();
}

class PopularTrainingSuccess extends PopularTrainingState {
  final List<ExerciseEntity> exercises;

  const PopularTrainingSuccess(this.exercises);

  @override
  List<Object?> get props => [exercises];
}

class PopularTrainingError extends PopularTrainingState {
  final Exception exception;

  const PopularTrainingError(this.exception);

  @override
  List<Object?> get props => [exception];
}