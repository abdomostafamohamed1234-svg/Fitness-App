import 'package:flowery/features/register/domain/use_cases/register_usecase.dart';
import 'package:flowery/features/register/presentation/view/widgets/choose_age_widget.dart';
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

  testWidgets('It starts with a lifespan of 20 years if there is no retained value', (tester) async {
    await tester.pumpApp(ChooseAgeWidget(registerCubit: cubit));
    expect(cubit.age, '20');
  });

  testWidgets('If there is a pre-saved age, it is used instead of the default one', (tester) async {
    cubit.age = '35';
    await tester.pumpApp(ChooseAgeWidget(registerCubit: cubit));
    expect(cubit.age, '35');
  });

}