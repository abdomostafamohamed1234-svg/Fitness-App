import 'package:bloc_test/bloc_test.dart';
import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/popular_training/data/models/exercise_model_reponse.dart';
import 'package:flowery/features/popular_training/domain/entities/exercise_entity.dart';
import 'package:flowery/features/popular_training/domain/usecase/get_exercises_usecase.dart';
import 'package:flowery/features/popular_training/presentation/view_model/popular_training_cubit.dart';
import 'package:flowery/features/popular_training/presentation/view_model/popular_training_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_training_cubit_test.mocks.dart';

// Run: flutter pub run build_runner build --delete-conflicting-outputs
//
// NOTE: this assumes `GetPopularTrainingUseCase` is a callable class
// (has a `call()` method), since the cubit invokes it as
// `getPopularTrainingUseCase()`. Adjust the `when(...)` stub below if the
// real method has a different name.
@GenerateMocks([GetPopularTrainingUseCase])
void main() {
  setUpAll(() {
    provideDummy<Result<List<ExerciseEntity>>>(
      const Success<List<ExerciseEntity>>(data: []),
    );
  });

  late MockGetPopularTrainingUseCase mockUseCase;

  const exercise = ExerciseModel(
    idJson: 'ex-1',
    nameJson: 'Curl',
    difficultyLevelJson: 'level-1',
    targetMuscleGroupJson: 'Arms',
    primeMoverMuscleJson: 'muscle-1',
  );

  setUp(() {
    mockUseCase = MockGetPopularTrainingUseCase();
  });

  PopularTrainingCubit buildCubit() => PopularTrainingCubit(mockUseCase);

  blocTest<PopularTrainingCubit, PopularTrainingState>(
    'emits [Loading, Success] when the use case succeeds',
    setUp: () {
      when(mockUseCase()).thenAnswer(
        (_) async => const Success<List<ExerciseEntity>>(data: [exercise]),
      );
    },
    build: buildCubit,
    act: (cubit) => cubit.getPopularTraining(),
    expect: () => [
      isA<PopularTrainingLoading>(),
      isA<PopularTrainingSuccess>(),
    ],
    verify: (_) {
      verify(mockUseCase()).called(1);
    },
  );

  blocTest<PopularTrainingCubit, PopularTrainingState>(
    'emits [Loading, Error] when the use case returns an Error result',
    setUp: () {
      when(mockUseCase()).thenAnswer(
        (_) async => Error<List<ExerciseEntity>>(
          exception: Exception('network error'),
        ),
      );
    },
    build: buildCubit,
    act: (cubit) => cubit.getPopularTraining(),
    expect: () => [
      isA<PopularTrainingLoading>(),
      isA<PopularTrainingError>(),
    ],
  );

  blocTest<PopularTrainingCubit, PopularTrainingState>(
    'emits [Loading, Success] with an empty list when Success.data is null',
    setUp: () {
      when(mockUseCase()).thenAnswer(
        (_) async => const Success<List<ExerciseEntity>>(data: null),
      );
    },
    build: buildCubit,
    act: (cubit) => cubit.getPopularTraining(),
    expect: () => [
      isA<PopularTrainingLoading>(),
      isA<PopularTrainingSuccess>(),
    ],
  );

  test('never emits after the cubit is closed', () async {
    when(mockUseCase()).thenAnswer(
      (_) async => const Success<List<ExerciseEntity>>(data: [exercise]),
    );

    final cubit = buildCubit();
    final future = cubit.getPopularTraining();
    await cubit.close();

    // Should complete without throwing a "Cannot emit after close" error.
    await future;
    expect(cubit.state, isA<PopularTrainingLoading>());
  });
}