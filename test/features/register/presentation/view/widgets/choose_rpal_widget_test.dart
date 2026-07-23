

import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/register/domain/entities/register_entity.dart';
import 'package:flowery/features/register/domain/use_cases/register_usecase.dart';
import 'package:flowery/features/register/presentation/view/widgets/choose_rpal_widget.dart';
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

  // ChooseRpalWidget no longer takes a `registerCubit` constructor param,
  // it reads the cubit from the widget tree instead, so it must be wrapped
  // in a BlocProvider to be tested in isolation.
  Widget wrap(Widget child) =>
      BlocProvider<RegisterCubit>.value(value: cubit, child: child);

  testWidgets('Selecting the activity level saves it in the cubit', (
    tester,
  ) async {
    await tester.pumpApp(wrap(const ChooseRpalWidget()));

    await tester.tap(find.text('Intermediate'));
    await tester.pump();

    expect(cubit.physicalActivityLevel, 'level3');
  });

  testWidgets('The Submit button is hidden until a level is selected', (
    tester,
  ) async {
    await tester.pumpApp(wrap(const ChooseRpalWidget()));

    final visibility = tester.widget<Visibility>(find.byType(Visibility));
    expect(visibility.visible, isFalse);
  });

  testWidgets('Pressing Submit calls RegisterUsecase.invoke', (tester) async {
    when(() => mockUsecase.invoke(any())).thenAnswer(
      (_) async =>
          Success<RegisterEntity>(data: RegisterEntity(message: 'Success')),
    );

    await tester.pumpApp(wrap(const ChooseRpalWidget()));

    await tester.tap(find.text('Rookie'));
    await tester.pump();
    await tester.tap(find.text('Submit'));

    await tester.pump(const Duration(seconds: 3));

    verify(() => mockUsecase.invoke(any())).called(1);
  });
}