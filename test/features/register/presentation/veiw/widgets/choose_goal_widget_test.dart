import 'package:flowery/features/register/domain/use_cases/register_usecase.dart';
import 'package:flowery/features/register/presentation/view/widgets/choose_goal_widget.dart';
import 'package:flowery/features/register/presentation/view_model/cubit/register_cubit.dart';
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

  testWidgets('يعرض كل الأهداف الخمسة', (tester) async {
    await tester.pumpApp(ChooseGoalWidget(registerCubit: cubit));

    expect(find.text('Gain Weight'), findsOneWidget);
    expect(find.text('Lose Weight'), findsOneWidget);
    expect(find.text('Get Fitter'), findsOneWidget);
    expect(find.text('Gain More Flexible'), findsOneWidget);
    expect(find.text('Learn The Basics'), findsOneWidget);
  });

  testWidgets('اختيار هدف يحفظه في الـ cubit', (tester) async {
    await tester.pumpApp(ChooseGoalWidget(registerCubit: cubit));

    await tester.tap(find.text('Lose Weight'));
    await tester.pump();

    expect(cubit.goal, 'Lose Weight');
  });

 
}