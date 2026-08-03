import 'package:bloc_test/bloc_test.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/base/base_state.dart';
import 'package:flowery/core/theme/app_theme.dart';
import 'package:flowery/features/login/domain/use_case/login_use_case.dart';
import 'package:flowery/features/login/presentation/view/widgets/login_body.dart';
import 'package:flowery/features/login/presentation/view_model/cubit.dart';
import 'package:flowery/features/login/presentation/view_model/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockLoginUseCase extends Mock implements LoginUseCase {}

class _MockLoginCubit extends MockCubit<LoginStates> implements LoginCubit {}

void main() {
  late LoginCubit loginCubit;

  setUp(() {
    loginCubit = LoginCubit(_MockLoginUseCase());
  });

  tearDown(() {
    loginCubit.close();
  });

  Future<void> pumpLoginBody(WidgetTester tester, LoginCubit cubit) {
    return tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => MaterialApp(
          theme: AppTheme.darkTheme,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: SingleChildScrollView(
              child: BlocProvider<LoginCubit>.value(
                value: cubit,
                child: LoginBody(loginCubit: cubit),
              ),
            ),
          ),
        ),
      ),
    );
  }

  testWidgets('renders all the expected login form elements', (tester) async {
    await pumpLoginBody(tester, loginCubit);

    expect(find.text('Hey There'), findsOneWidget);
    expect(find.text('WELCOME BACK'), findsOneWidget);
    // "Login" appears twice: the card title and the submit button.
    expect(find.text('Login'), findsNWidgets(2));
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Forget Password?'), findsOneWidget);
    expect(find.text('Or'), findsOneWidget);
    expect(find.text('Dont Have An Account Yet ? '), findsOneWidget);
    expect(find.text('Register'), findsOneWidget);

    // Facebook, Google ("G") and Apple social buttons.
    expect(find.byIcon(Icons.facebook), findsOneWidget);
    expect(find.byIcon(Icons.apple), findsOneWidget);
    expect(find.text('G'), findsOneWidget);
  });

  testWidgets('toggles password visibility when the eye icon is tapped', (tester) async {
    await pumpLoginBody(tester, loginCubit);

    expect(find.byIcon(Icons.visibility_off), findsOneWidget);
    expect(find.byIcon(Icons.visibility), findsNothing);

    await tester.tap(find.byIcon(Icons.visibility_off));
    await tester.pump();

    expect(find.byIcon(Icons.visibility), findsOneWidget);
    expect(find.byIcon(Icons.visibility_off), findsNothing);
  });

  testWidgets('shows validation errors when submitting empty fields', (tester) async {
    await pumpLoginBody(tester, loginCubit);

    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pumpAndSettle();

    // Both empty fields share the same "required" message.
    expect(find.text('This field is required'), findsNWidgets(2));
  });

  testWidgets('shows an email format error for an invalid email', (tester) async {
    await pumpLoginBody(tester, loginCubit);

    await tester.enterText(find.widgetWithText(TextFormField, 'Email'), 'not-an-email');
    await tester.enterText(find.widgetWithText(TextFormField, 'Password'), 'Password123!');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pumpAndSettle();

    expect(find.text('Enter a valid email'), findsOneWidget);
  });

  testWidgets('shows a spinner and disables the button while loading', (tester) async {
    final mockCubit = _MockLoginCubit();
    addTearDown(() => mockCubit.close());

    whenListen(
      mockCubit,
      const Stream<LoginStates>.empty(),
      initialState: const LoginStates(loginState: BaseState.loading()),
    );

    await pumpLoginBody(tester, mockCubit);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    // Only the card title renders "Login" text now; the button shows the spinner instead.
    expect(find.text('Login'), findsOneWidget);

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, isNull);
  });
}
