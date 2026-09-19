import 'package:bloc_test/bloc_test.dart';
import 'package:flowery/features/exercises/domain/use_case/exercise_use_case_.dart';
import 'package:flowery/features/exercises/domain/use_case/levels_use_case.dart';
import 'package:flowery/features/exercises/presentation/view_model/base_state/exercise_state.dart';
import 'package:flowery/features/exercises/presentation/view_model/cubit/exercise_cubit.dart';
import 'package:flowery/features/exercises/presentation/view_model/events/exercise_events.dart';
import 'package:mocktail/mocktail.dart';

class MockLevelsUseCase extends Mock implements LevelsUseCase {}

class MockExerciseUseCase extends Mock implements ExerciseUseCase {}

class MockExerciseCubit extends MockCubit<ExerciseState>
    implements ExerciseCubit {}

final ExerciseEvents fallbackExerciseEvent =
    ToggleExerciseVideoEvent(exerciseId: "fallback");