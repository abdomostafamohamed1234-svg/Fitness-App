import 'package:bloc_test/bloc_test.dart';
import 'package:flowery/config/exception_handlers/app_exception.dart';
import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/core/base/base_state.dart';
import 'package:flowery/features/exercises/domain/entities/exercises_entity.dart';
import 'package:flowery/features/exercises/domain/entities/levels_entity.dart';
import 'package:flowery/features/exercises/presentation/view_model/base_state/exercise_state.dart';
import 'package:flowery/features/exercises/presentation/view_model/cubit/exercise_cubit.dart';
import 'package:flowery/features/exercises/presentation/view_model/events/exercise_events.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../../../helpers/exercise_test_helpers.dart';


void main() {
  late MockLevelsUseCase levelsUseCase;
  late MockExerciseUseCase exerciseUseCase;

  const muscleId = "chest-muscle-id";

  final level1 = const DifficultyLevelEntity(id: "l1", name: "Beginner");
  final level2 = const DifficultyLevelEntity(id: "l2", name: "Advanced");
  final levelsEntity = LevelsEntity(
    message: "success",
    totalLevels: 2,
    difficultyLevels: [level1, level2],
  );

  final exercise1 = const ExerciseEntity(
    id: "e1",
    exercise: "Push Up",
    difficultyLevel: "Beginner",
    targetMuscleGroup: "Chest",
    primaryEquipment: "Bodyweight",
    mechanics: "Compound",
    shortYoutubeDemonstrationLink: "https://youtu.be/abc123",
  );
  final exercisesEntity = ExercisesEntity(
    message: "success",
    totalExercises: 1,
    totalPages: 1,
    currentPage: 1,
    exercises: [exercise1],
  );

  setUpAll(() {
    registerFallbackValue(fallbackExerciseEvent);
  });

  setUp(() {
    levelsUseCase = MockLevelsUseCase();
    exerciseUseCase = MockExerciseUseCase();
  });

  ExerciseCubit buildCubit() => ExerciseCubit(levelsUseCase, exerciseUseCase);

  group("LoadExerciseLevelsEvent", () {
    blocTest<ExerciseCubit, ExerciseState>(
      "emits loading→success for levels, then auto-selects first level "
      "and loads its exercises (loading→success)",
      setUp: () {
        when(() => levelsUseCase.call(muscleId))
            .thenAnswer((_) async => Success<LevelsEntity>(data: levelsEntity));
        when(() => exerciseUseCase.call(muscleId, level1.id!))
            .thenAnswer((_) async => Success<ExercisesEntity>(data: exercisesEntity));
      },
      build: buildCubit,
      act: (cubit) => cubit.doEvent(LoadExerciseLevelsEvent(muscleId: muscleId)),
      expect: () => [
       const ExerciseState(muscleId: muscleId, levelsState:  BaseState.loading()),
        ExerciseState(
          muscleId: muscleId,
          levelsState: BaseState.success(levelsEntity),
        ),
        ExerciseState(
          muscleId: muscleId,
          levelsState: BaseState.success(levelsEntity),
          selectedLevelId: level1.id!,
        ),
        ExerciseState(
          muscleId: muscleId,
          levelsState: BaseState.success(levelsEntity),
          selectedLevelId: level1.id!,
          exercisesState: const BaseState.loading(),
        ),
        ExerciseState(
          muscleId: muscleId,
          levelsState: BaseState.success(levelsEntity),
          selectedLevelId: level1.id!,
          exercisesState: BaseState.success(exercisesEntity),
        ),
      ],
      verify: (_) {
        verify(() => levelsUseCase.call(muscleId)).called(1);
        verify(() => exerciseUseCase.call(muscleId, level1.id!)).called(1);
      },
    );

    blocTest<ExerciseCubit, ExerciseState>(
      "emits loading→error when the levels use case fails, "
      "and never calls the exercises use case",
      setUp: () {
        when(() => levelsUseCase.call(muscleId)).thenAnswer(
          (_) async =>const Error<LevelsEntity>(
            exception: AppException("Network error"),
          ),
        );
      },
      build: buildCubit,
      act: (cubit) => cubit.doEvent(LoadExerciseLevelsEvent(muscleId: muscleId)),
      expect: () => [
       const ExerciseState(muscleId: muscleId, levelsState:  BaseState.loading()),
        isA<ExerciseState>()
            .having((s) => s.levelsState.state, "levelsState.state", StateType.error)
            .having(
              (s) => (s.levelsState.exception as AppException?)?.toString(),
              "error message",
              contains("Network error"),
            ),
      ],
      verify: (_) {
        verifyNever(() => exerciseUseCase.call(any(), any()));
      },
    );

    blocTest<ExerciseCubit, ExerciseState>(
      "emits an error for exercises when levels succeed but exercises fail",
      setUp: () {
        when(() => levelsUseCase.call(muscleId))
            .thenAnswer((_) async => Success<LevelsEntity>(data: levelsEntity));
        when(() => exerciseUseCase.call(muscleId, level1.id!)).thenAnswer(
          (_) async =>const Error<ExercisesEntity>(
            exception: AppException("Server error"),
          ),
        );
      },
      build: buildCubit,
      act: (cubit) => cubit.doEvent(LoadExerciseLevelsEvent(muscleId: muscleId)),
      skip: 3, 
      expect: () => [
        isA<ExerciseState>().having(
          (s) => s.exercisesState.state,
          "exercisesState.state",
          StateType.loading,
        ),
        isA<ExerciseState>().having(
          (s) => s.exercisesState.state,
          "exercisesState.state",
          StateType.error,
        ),
      ],
    );

    blocTest<ExerciseCubit, ExerciseState>(
      "does not try to auto-select a level when the levels list is empty",
      setUp: () {
        when(() => levelsUseCase.call(muscleId)).thenAnswer(
          (_) async =>const Success<LevelsEntity>(
            data:  LevelsEntity(
              message: "success",
              totalLevels: 0,
              difficultyLevels: [],
            ),
          ),
        );
      },
      build: buildCubit,
      act: (cubit) => cubit.doEvent(LoadExerciseLevelsEvent(muscleId: muscleId)),
      expect: () => [
       const ExerciseState(muscleId: muscleId, levelsState:  BaseState.loading()),
        isA<ExerciseState>().having(
          (s) => s.selectedLevelId,
          "selectedLevelId stays empty",
          "",
        ),
      ],
      verify: (_) {
        verifyNever(() => exerciseUseCase.call(any(), any()));
      },
    );
  });

  group("SelectDifficultyLevelEvent", () {
    blocTest<ExerciseCubit, ExerciseState>(
      "re-fetches exercises when a different level is selected",
      setUp: () {
        when(() => exerciseUseCase.call(muscleId, level2.id!)).thenAnswer(
          (_) async => Success<ExercisesEntity>(data: exercisesEntity),
        );
      },
      build: buildCubit,
      seed: () => ExerciseState(muscleId: muscleId, selectedLevelId: level1.id!),
      act: (cubit) => cubit.doEvent(
        SelectDifficultyLevelEvent(oldLevelId: level1.id!, newLevelId: level2.id!),
      ),
      expect: () => [
        ExerciseState(
          muscleId: muscleId,
          selectedLevelId: level2.id!,
        ),
        ExerciseState(
          muscleId: muscleId,
          selectedLevelId: level2.id!,
          exercisesState: const BaseState.loading(),
        ),
        ExerciseState(
          muscleId: muscleId,
          selectedLevelId: level2.id!,
          exercisesState: BaseState.success(exercisesEntity),
        ),
      ],
    );

    blocTest<ExerciseCubit, ExerciseState>(
      "does nothing extra (no exercises re-fetch) when tapping the "
      "already-selected level again",
      build: buildCubit,
      seed: () => ExerciseState(muscleId: muscleId, selectedLevelId: level1.id!),
      act: (cubit) => cubit.doEvent(
        SelectDifficultyLevelEvent(oldLevelId: level1.id!, newLevelId: level1.id!),
      ),
      expect: () => [],
      verify: (_) {
        verifyNever(() => exerciseUseCase.call(any(), any()));
      },
    );
  });

  group("ToggleExerciseVideoEvent", () {
    blocTest<ExerciseCubit, ExerciseState>(
      "sets playingExerciseId when toggling a video on",
      build: buildCubit,
      act: (cubit) =>
          cubit.doEvent(ToggleExerciseVideoEvent(exerciseId: "e1")),
      expect: () => [
        const ExerciseState(playingExerciseId: "e1"),
      ],
    );

    blocTest<ExerciseCubit, ExerciseState>(
      "clears playingExerciseId when toggling the same video off again",
      build: buildCubit,
      seed: () => const ExerciseState(playingExerciseId: "e1"),
      act: (cubit) =>
          cubit.doEvent(ToggleExerciseVideoEvent(exerciseId: "e1")),
      expect: () => [
        const ExerciseState(playingExerciseId: null),
      ],
    );

    blocTest<ExerciseCubit, ExerciseState>(
      "switches to a different video when another one is tapped while "
      "one is already playing",
      build: buildCubit,
      seed: () => const ExerciseState(playingExerciseId: "e1"),
      act: (cubit) =>
          cubit.doEvent(ToggleExerciseVideoEvent(exerciseId: "e2")),
      expect: () => [
        const ExerciseState(playingExerciseId: "e2"),
      ],
    );
  });
}