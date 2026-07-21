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

  testWidgets('يبدأ بعمر افتراضي 20 لو مفيش قيمة محفوظة', (tester) async {
    await tester.pumpApp(ChooseAgeWidget(registerCubit: cubit));
    expect(cubit.age, '20');
  });

  testWidgets('لو فيه عمر محفوظ مسبقًا، بيستخدمه بدل الافتراضي', (tester) async {
    cubit.age = '35';
    await tester.pumpApp(ChooseAgeWidget(registerCubit: cubit));
    expect(cubit.age, '35');
  });

}