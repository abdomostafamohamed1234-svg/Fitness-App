import 'package:flowery/features/register/domain/use_cases/register_usecase.dart';
import 'package:flowery/features/register/presentation/view/widgets/choose_gender_widget.dart';
import 'package:flowery/features/register/presentation/view_model/cubit/register_cubit.dart';
import 'package:flutter/material.dart';
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

  testWidgets('Displays both Male and Female options', (tester) async {
    await tester.pumpApp(ChooseGenderWidget(registerCubit: cubit));

    expect(find.text('Male'), findsOneWidget);
    expect(find.text('Female'), findsOneWidget);
  });

  testWidgets('The Next button is hidden before you make a selection', (tester) async {
    await tester.pumpApp(ChooseGenderWidget(registerCubit: cubit));

    final visibility = tester.widget<Visibility>(find.byType(Visibility));
    expect(visibility.visible, isFalse);
  });

  testWidgets('Selecting Male saves the value and displays the Next button', (tester) async {
    await tester.pumpApp(ChooseGenderWidget(registerCubit: cubit));

    await tester.tap(find.text('Male'));
    await tester.pump();

    expect(cubit.gender, 'male');
    final visibility = tester.widget<Visibility>(find.byType(Visibility));
    expect(visibility.visible, isTrue);
  });

  testWidgets('Choosing Female preserves the correct value', (tester) async {
    await tester.pumpApp(ChooseGenderWidget(registerCubit: cubit));

    await tester.tap(find.text('Female'));
    await tester.pump();

    expect(cubit.gender, 'female');
  });



testWidgets('Pressing Next after selection provides the next step', (tester) async {
  await tester.pumpApp(ChooseGenderWidget(registerCubit: cubit));

  await tester.tap(find.text('Male'));
  await tester.pump();

  // الضغطة الأولى بتظبط registerState من null لـ BaseState(data: 0) بس
  await tester.tap(find.text('Next'));
  await tester.pump();

  // الضغطة الثانية هي اللي فعليًا بتزود القيمة لـ 1
  await tester.tap(find.text('Next'));
  await tester.pump();

  expect(cubit.state.registerState?.data, 1);
});
 
}