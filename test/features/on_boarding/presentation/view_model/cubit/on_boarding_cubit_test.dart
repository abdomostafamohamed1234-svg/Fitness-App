import 'package:bloc_test/bloc_test.dart';
import 'package:flowery/features/on_boarding/presentation/view_model/cubit/on_boarding_cubit.dart';
import 'package:flowery/features/on_boarding/presentation/view_model/events/on_boarding_events.dart';
import 'package:flowery/features/on_boarding/presentation/view_model/state/on_boarding_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late OnBoardingCubit cubit;

  setUp(() {
    cubit = OnBoardingCubit();
  });

  tearDown(() {
    cubit.close();
  });

  test('Initial state should be pageNumber = 0', () {
    expect(cubit.state, const OnBoardingState());
  });

  blocTest<OnBoardingCubit, OnBoardingState>(
    'emits pageNumber = 1 when ChangePageEvent(1) is added',
    build: () => OnBoardingCubit(),
    act: (cubit) {
      cubit.doEvent(
        ChangePageEvent(pageNumber: 1),
      );
    },
    expect: () => [
      const OnBoardingState(pageNumber: 1),
    ],
  );

  blocTest<OnBoardingCubit, OnBoardingState>(
    'emits pageNumber = 2 when ChangePageEvent(2) is added',
    build: () => OnBoardingCubit(),
    act: (cubit) {
      cubit.doEvent(
        ChangePageEvent(pageNumber: 2),
      );
    },
    expect: () => [
      const OnBoardingState(pageNumber: 2),
    ],
  );
}