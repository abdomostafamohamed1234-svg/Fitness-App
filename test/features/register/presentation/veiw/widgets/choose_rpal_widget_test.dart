import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/register/domain/entities/register_model.dart';
import 'package:flowery/features/register/domain/use_cases/register_usecase.dart';
import 'package:flowery/features/register/presentation/view/widgets/choose_rpal_widget.dart';
import 'package:flowery/features/register/presentation/view_model/cubit/register_cubit.dart';
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

  testWidgets('اختيار مستوى النشاط يحفظه بالـ cubit', (tester) async {
    await tester.pumpApp(ChooseRpalWidget(registerCubit: cubit));

    await tester.tap(find.text('Intermediate'));
    await tester.pump();

    expect(cubit.physicalActivityLevel, 'level3');
  });

  testWidgets('الضغط على Submit يستدعي RegisterUsecase.invoke', (tester) async {
    when(() => mockUsecase.invoke(any())).thenAnswer(
      (_) async => Success<RegisterModel>(
        data: RegisterModel(massage: 'Success'),
      ),
    );

    await tester.pumpApp(ChooseRpalWidget(registerCubit: cubit));

    await tester.tap(find.text('Rookie'));
    await tester.pump();
    await tester.tap(find.text('Submit'));

    await tester.pump(const Duration(seconds: 3));

    verify(() => mockUsecase.invoke(any())).called(1);
  });
}
