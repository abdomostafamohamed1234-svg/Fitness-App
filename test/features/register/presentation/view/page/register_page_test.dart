import 'package:flowery/config/di/di_config.dart';
import 'package:flowery/config/routing/app_routes.dart';
import 'package:flowery/features/register/domain/use_cases/register_usecase.dart';
import 'package:flowery/features/register/presentation/view/pages/register_page.dart';
import 'package:flowery/features/register/presentation/view_model/cubit/register_cubit.dart';
import 'package:flowery/features/register/presentation/view_model/cubit/register_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../helpers/l10n.dart';
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

  testWidgets('Opening the page starts at the form step', (tester) async {
    await tester.pumpApp(const RegisterPage());
    expect(find.text(l10n.register), findsWidgets);
  });

  testWidgets('ShowLoadingEvent displays a CircularProgressIndicator as a Dialog', (tester) async {
    await tester.pumpApp(const RegisterPage());

    cubit.doIntent(ShowLoadingEvent());
    // Use pump with a fixed duration instead of pumpAndSettle() because the
    // CircularProgressIndicator has an infinite animation that never settles.
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.byType(CircularProgressIndicator), findsWidgets);
  });

  testWidgets('ShowMassageEvent displays an AlertDialog with the correct message', (tester) async {
    await tester.pumpApp(const RegisterPage());
    cubit.doIntent(ShowMassageEvent('Test Message'));
    await tester.pumpAndSettle();

    expect(find.text('Test Message'), findsOneWidget);
    expect(find.text(l10n.ok), findsOneWidget);
  });

  testWidgets('NavigateToLoginEvent navigates to the login page', (tester) async {
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