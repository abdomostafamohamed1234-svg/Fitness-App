

import 'package:flowery/features/register/domain/use_cases/register_usecase.dart';
import 'package:flowery/features/register/presentation/view/widgets/choose_gender_widget.dart';
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

  setUpAll(() {
    registerFallbackValue(<String, dynamic>{});
  });

  setUp(() {
    mockUsecase = MockRegisterUsecase();
    cubit = RegisterCubit(mockUsecase);
  });

  tearDown(() async => cubit.close());

  // ChooseGenderWidget no longer takes a `registerCubit` constructor param,
  // it reads the cubit from the widget tree instead, so it must be wrapped
  // in a BlocProvider to be tested in isolation.
  Widget wrap(Widget child) =>
      BlocProvider<RegisterCubit>.value(value: cubit, child: child);

  testWidgets('Displays both Male and Female options', (tester) async {
    await tester.pumpApp(wrap(const ChooseGenderWidget()));

    expect(find.text('Male'), findsOneWidget);
    expect(find.text('Female'), findsOneWidget);
  });

  testWidgets('The Next button is hidden before you make a selection', (
    tester,
  ) async {
    await tester.pumpApp(wrap(const ChooseGenderWidget()));

    final visibility = tester.widget<Visibility>(find.byType(Visibility));
    expect(visibility.visible, isFalse);
  });

  testWidgets('Selecting Male saves the value and displays the Next button', (
    tester,
  ) async {
    await tester.pumpApp(wrap(const ChooseGenderWidget()));

    await tester.tap(find.text('Male'));
    await tester.pump();

    expect(cubit.gender, 'male');
    final visibility = tester.widget<Visibility>(find.byType(Visibility));
    expect(visibility.visible, isTrue);
  });

  testWidgets('Choosing Female preserves the correct value', (tester) async {
    await tester.pumpApp(wrap(const ChooseGenderWidget()));

    await tester.tap(find.text('Female'));
    await tester.pump();

    expect(cubit.gender, 'female');
  });

  testWidgets('Pressing Next after selection advances the step', (
    tester,
  ) async {
    await tester.pumpApp(wrap(const ChooseGenderWidget()));

    await tester.tap(find.text('Male'));
    await tester.pump();

    // First tap only moves currentStepState from null to BaseState(data: 0)
    await tester.tap(find.text('Next'));
    await tester.pump();

    // Second tap actually increments the value to 1
    await tester.tap(find.text('Next'));
    await tester.pump();

    expect(cubit.state.currentStepState?.data, 1);
  });
}