import 'package:flowery/config/di/di_config.dart';
import 'package:flowery/config/routing/app_routes.dart';
import 'package:flowery/features/register/domain/use_cases/register_usecase.dart';
import 'package:flowery/features/register/presentation/view/pages/register_page.dart';
import 'package:flowery/features/register/presentation/view_model/cubit/register_cubit.dart';
import 'package:flowery/features/register/presentation/view_model/cubit/register_events.dart';
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
    getIt.registerSingleton<RegisterCubit>(cubit);
  });

  tearDown(() async {
    await getIt.reset();
  });

  testWidgets('أول ما تفتح الصفحة بتبدأ بخطوة الفورم', (tester) async {
    await tester.pumpApp(const RegisterPage());
    expect(find.text('Register'), findsWidgets);
  });

  testWidgets('ShowLoadingTempEvent بيعرض CircularProgressIndicator كـ Dialog', (tester) async {
    await tester.pumpApp(const RegisterPage());

    cubit.doIntent(ShowLoadingEvent());
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsWidgets);
  });

  testWidgets('ShowMassageTempEvent بيعرض AlertDialog بالرسالة الصح', (tester) async {
    await tester.pumpApp(const RegisterPage());
cubit.doIntent(ShowMassageEvent('Test Message'));
await tester.pumpAndSettle();

expect(find.text('Test Message'), findsOneWidget);
expect(find.text('OK'), findsOneWidget);
 
  });

  testWidgets('NavigateToLoginTempEvent بيعمل navigate لصفحة اللوجن', (tester) async {
    await tester.pumpApp(
      const RegisterPage(),
      routes: {
        AppRoutes.login: (_) => const Scaffold(body: Text('Login Page')),
      },
    );

    cubit.doIntent(NavigateToLoginEvent());
    await tester.pumpAndSettle();

    expect(find.text('Login Page'), findsOneWidget);
  });
}