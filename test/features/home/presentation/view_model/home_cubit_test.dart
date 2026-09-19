import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/core/base/base_state.dart';
import 'package:flowery/features/home/domian/entities/food_for_you_model.dart';
import 'package:flowery/features/home/domian/entities/profile_model.dart';
import 'package:flowery/features/home/domian/entities/recommendation_model.dart';
import 'package:flowery/features/home/domian/entities/work_out_model.dart';
import 'package:flowery/features/home/domian/use_case/use_case.dart';
import 'package:flowery/features/home/presentation/view_model/home_cubit.dart';
import 'package:flowery/features/home/presentation/view_model/home_event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_cubit_test.mocks.dart';

@GenerateMocks([HomeUseCase])
void main() {
  late MockHomeUseCase mockHomeUseCase;
  late HomeCubit homeCubit;

  // ---- Fixtures ----
  final foodModel = FoodForYouModel(categories: const []);
  final workOutModel = WorkOutModel(message: 'ok', musclesGroup: const []);
  final recommendationModel = RecommendationModel(
    message: 'ok',
    totalMuscles: 0,
    muscles: const [],
  );
  final profileModel = ProfileModel(
    firstName: 'John',
    lastName: 'Doe',
    photo: 'photo.png',
  );
  final testException = Exception('request failed');

  setUp(() {
    mockHomeUseCase = MockHomeUseCase();
    homeCubit = HomeCubit(mockHomeUseCase);
  });

  tearDown(() async {
    await homeCubit.close();
  });

  // Helper to read the terminal branch of a BaseState without caring
  // about the internal implementation.
  void expectSuccess<T>(BaseState<T> state, T expected) {
    state.when(
      initial: () => fail('expected success, got initial'),
      loading: () => fail('expected success, got loading'),
      success: (data) => expect(data, expected),
      error: (e) => fail('expected success, got error: $e'),
    );
  }

  void expectError<T>(BaseState<T> state, Exception expected) {
    state.when(
      initial: () => fail('expected error, got initial'),
      loading: () => fail('expected error, got loading'),
      success: (_) => fail('expected error, got success'),
      error: (e) => expect(e, expected),
    );
  }

  void expectLoading<T>(BaseState<T> state) {
    state.when(
      initial: () => fail('expected loading, got initial'),
      loading: () {},
      success: (_) => fail('expected loading, got success'),
      error: (_) => fail('expected loading, got error'),
    );
  }

  test('initial state has all BaseState fields as initial', () {
    homeCubit.state.foodState.when(
      initial: () {},
      loading: () => fail('expected initial'),
      success: (_) => fail('expected initial'),
      error: (_) => fail('expected initial'),
    );
  });

  group('GetFoodDataEvent', () {
    test('emits [loading, success] when use case succeeds', () async {
      when(mockHomeUseCase.callFoodData())
          .thenAnswer((_) async => Success(data: foodModel));

      final statesFuture = homeCubit.stream.take(2).toList();
      homeCubit.doAction(GetFoodDataEvent());
      final states = await statesFuture;

      expectLoading(states[0].foodState);
      expectSuccess(states[1].foodState, foodModel);
      verify(mockHomeUseCase.callFoodData()).called(1);
    });

    test('emits [loading, error] when use case fails', () async {
      when(mockHomeUseCase.callFoodData())
          .thenAnswer((_) async => Error(exception: testException));

      final statesFuture = homeCubit.stream.take(2).toList();
      homeCubit.doAction(GetFoodDataEvent());
      final states = await statesFuture;

      expectLoading(states[0].foodState);
      expectError(states[1].foodState, testException);
    });
  });

  group('GetWorkOutDataEvent', () {
    test('emits [loading, success] when use case succeeds', () async {
      when(mockHomeUseCase.callWorkOutData())
          .thenAnswer((_) async => Success(data: workOutModel));

      final statesFuture = homeCubit.stream.take(2).toList();
      homeCubit.doAction(GetWorkOutDataEvent());
      final states = await statesFuture;

      expectLoading(states[0].workOutState);
      expectSuccess(states[1].workOutState, workOutModel);
      verify(mockHomeUseCase.callWorkOutData()).called(1);
    });

    test('emits [loading, error] when use case fails', () async {
      when(mockHomeUseCase.callWorkOutData())
          .thenAnswer((_) async => Error(exception: testException));

      final statesFuture = homeCubit.stream.take(2).toList();
      homeCubit.doAction(GetWorkOutDataEvent());
      final states = await statesFuture;

      expectLoading(states[0].workOutState);
      expectError(states[1].workOutState, testException);
    });
  });

  group('GetRecommendationDataEvent', () {
    test('emits [loading, success] when use case succeeds', () async {
      when(mockHomeUseCase.callRecommendationData())
          .thenAnswer((_) async => Success(data: recommendationModel));

      final statesFuture = homeCubit.stream.take(2).toList();
      homeCubit.doAction(GetRecommendationDataEvent());
      final states = await statesFuture;

      expectLoading(states[0].recommendationState);
      expectSuccess(states[1].recommendationState, recommendationModel);
      verify(mockHomeUseCase.callRecommendationData()).called(1);
    });

    test('emits [loading, error] when use case fails', () async {
      when(mockHomeUseCase.callRecommendationData())
          .thenAnswer((_) async => Error(exception: testException));

      final statesFuture = homeCubit.stream.take(2).toList();
      homeCubit.doAction(GetRecommendationDataEvent());
      final states = await statesFuture;

      expectLoading(states[0].recommendationState);
      expectError(states[1].recommendationState, testException);
    });
  });

  group('GetProfileDataEvent', () {
    test('emits [loading, success] when use case succeeds', () async {
      when(mockHomeUseCase.callProfileData())
          .thenAnswer((_) async => Success(data: profileModel));

      final statesFuture = homeCubit.stream.take(2).toList();
      homeCubit.doAction(GetProfileDataEvent());
      final states = await statesFuture;

      expectLoading(states[0].profileState);
      expectSuccess(states[1].profileState, profileModel);
      verify(mockHomeUseCase.callProfileData()).called(1);
    });

    test('emits [loading, error] when use case fails', () async {
      when(mockHomeUseCase.callProfileData())
          .thenAnswer((_) async => Error(exception: testException));

      final statesFuture = homeCubit.stream.take(2).toList();
      homeCubit.doAction(GetProfileDataEvent());
      final states = await statesFuture;

      expectLoading(states[0].profileState);
      expectError(states[1].profileState, testException);
    });
  });

  group('GetAllDataEvent', () {
    test('fetches food, workout, recommendation and profile concurrently',
        () async {
      when(mockHomeUseCase.callFoodData())
          .thenAnswer((_) async => Success(data: foodModel));
      when(mockHomeUseCase.callWorkOutData())
          .thenAnswer((_) async => Success(data: workOutModel));
      when(mockHomeUseCase.callRecommendationData())
          .thenAnswer((_) async => Success(data: recommendationModel));
      when(mockHomeUseCase.callProfileData())
          .thenAnswer((_) async => Success(data: profileModel));

      // 4 sections x [loading, success] = 8 emissions total.
      final statesFuture = homeCubit.stream.take(8).toList();
      homeCubit.doAction(GetAllDataEvent());
      final states = await statesFuture;

      final finalState = states.last;
      expectSuccess(finalState.foodState, foodModel);
      expectSuccess(finalState.workOutState, workOutModel);
      expectSuccess(finalState.recommendationState, recommendationModel);
      expectSuccess(finalState.profileState, profileModel);

      verify(mockHomeUseCase.callFoodData()).called(1);
      verify(mockHomeUseCase.callWorkOutData()).called(1);
      verify(mockHomeUseCase.callRecommendationData()).called(1);
      verify(mockHomeUseCase.callProfileData()).called(1);
    });
  });

  test('does not emit after the cubit is closed', () async {
    when(mockHomeUseCase.callFoodData())
        .thenAnswer((_) async => Success(data: foodModel));

    await homeCubit.close();

    // Should be a no-op thanks to the isClosed guard in emit().
    expect(() => homeCubit.doAction(GetFoodDataEvent()), returnsNormally);
  });
}