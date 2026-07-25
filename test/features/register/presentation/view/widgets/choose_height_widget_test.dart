import 'package:flowery/features/register/domain/use_cases/register_usecase.dart';
import 'package:flowery/features/register/presentation/view/widgets/choose_height_widget.dart';
import 'package:flowery/features/register/presentation/view_model/cubit/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../helpers/pump_app.dart';

class MockRegisterUsecase extends Mock implements RegisterUsecase {}

void main() {
  late MockRegisterUsecase mockUsecase;
  late RegisterCubit cubit;

  setUp(() {
    mockUsecase = MockRegisterUsecase();
    cubit = RegisterCubit(mockUsecase);
  });

  tearDown(() async => cubit.close());

  // ChooseHeightWidget reads the cubit from the widget tree via
  // context.read<RegisterCubit>(), so it must be wrapped in a BlocProvider
  // to be tested in isolation.
  Widget wrap(Widget child) =>
      BlocProvider<RegisterCubit>.value(value: cubit, child: child);

  testWidgets(
    'It starts with a height of 170 if there is no retained value',
    (tester) async {
      await tester.pumpApp(wrap(const ChooseHeightWidget()));
      expect(cubit.height, 170);
    },
  );

  testWidgets(
    'If there is a pre-saved height, it is used instead of the default one',
    (tester) async {
      cubit.height = 182;
      await tester.pumpApp(wrap(const ChooseHeightWidget()));
      expect(cubit.height, 182);
    },
  );

  testWidgets('Changing the picker value updates the cubit', (tester) async {
    await tester.pumpApp(wrap(const ChooseHeightWidget()));

    cubit.height = 190;
    await tester.pump();

    expect(cubit.height, 190);
  });

  testWidgets('Pressing Next advances the step', (tester) async {
    await tester.pumpApp(wrap(const ChooseHeightWidget()));

    // First tap only moves currentStepState from null to BaseState(data: 0)
    await tester.tap(find.text('Next'));
    await tester.pump();

    // Second tap actually increments the value to 1
    await tester.tap(find.text('Next'));
    await tester.pump();

    expect(cubit.state.currentStepState?.data, 1);
  });
}