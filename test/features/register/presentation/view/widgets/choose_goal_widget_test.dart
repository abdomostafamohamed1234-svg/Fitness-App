
import 'package:flowery/features/register/domain/use_cases/register_usecase.dart';
import 'package:flowery/features/register/presentation/view/widgets/choose_goal_widget.dart';
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

  // ChooseGoalWidget no longer takes a `registerCubit` constructor param,
  // it reads the cubit from the widget tree instead, so it must be wrapped
  // in a BlocProvider to be tested in isolation.
  Widget wrap(Widget child) =>
      BlocProvider<RegisterCubit>.value(value: cubit, child: child);

  testWidgets('Displays all five goals', (tester) async {
    await tester.pumpApp(wrap(const ChooseGoalWidget()));

    expect(find.text('Gain Weight'), findsOneWidget);
    expect(find.text('Lose Weight'), findsOneWidget);
    expect(find.text('Get Fitter'), findsOneWidget);
    expect(find.text('Gain More Flexible'), findsOneWidget);
    expect(find.text('Learn The Basics'), findsOneWidget);
  });

  testWidgets('Choosing a goal stores its value in the cubit', (
    tester,
  ) async {
    await tester.pumpApp(wrap(const ChooseGoalWidget()));

    await tester.tap(find.text('Lose Weight'));
    await tester.pump();

    expect(cubit.goal, 'Lose Weight');
  });

  testWidgets('The Next button is hidden before a goal is chosen', (
    tester,
  ) async {
    await tester.pumpApp(wrap(const ChooseGoalWidget()));

    final visibility = tester.widget<Visibility>(find.byType(Visibility));
    expect(visibility.visible, isFalse);
  });

  testWidgets('The Next button appears once a goal is chosen', (
    tester,
  ) async {
    await tester.pumpApp(wrap(const ChooseGoalWidget()));

    await tester.tap(find.text('Get Fitter'));
    await tester.pump();

    final visibility = tester.widget<Visibility>(find.byType(Visibility));
    expect(visibility.visible, isTrue);
  });
}