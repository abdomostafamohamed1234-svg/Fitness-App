import 'package:flowery/core/theme/app_theme.dart';
import 'package:flowery/features/login/domain/use_case/login_use_case.dart';
import 'package:flowery/features/login/presentation/view/widgets/login_body.dart';
import 'package:flowery/features/login/presentation/view_model/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockLoginUseCase extends Mock implements LoginUseCase {}

void main() {
  late LoginCubit loginCubit;

  setUp(() {
    loginCubit = LoginCubit(_MockLoginUseCase());
  });

  tearDown(() {
    loginCubit.close();
  });

  Future<void> pumpLoginBody(WidgetTester tester) {
    return tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => MaterialApp(
          theme: AppTheme.darkTheme,
          home: Scaffold(
            body: SingleChildScrollView(
              child: LoginBody(loginCubit: loginCubit),
            ),
          ),
        ),
      ),
    );
  }

  testWidgets('renders all the expected login form elements', (tester) async {
    await pumpLoginBody(tester);

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
    await pumpLoginBody(tester);

    expect(find.byIcon(Icons.visibility_off), findsOneWidget);
    expect(find.byIcon(Icons.visibility), findsNothing);

    await tester.tap(find.byIcon(Icons.visibility_off));
    await tester.pump();

    expect(find.byIcon(Icons.visibility), findsOneWidget);
    expect(find.byIcon(Icons.visibility_off), findsNothing);
  });

  testWidgets('shows validation errors when submitting empty fields', (tester) async {
    await pumpLoginBody(tester);

    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pumpAndSettle();

    expect(find.text('Email is required'), findsOneWidget);
    expect(find.text('Password is required'), findsOneWidget);
  });

  testWidgets('shows an email format error for an invalid email', (tester) async {
    await pumpLoginBody(tester);

    await tester.enterText(find.widgetWithText(TextFormField, 'Email'), 'not-an-email');
    await tester.enterText(find.widgetWithText(TextFormField, 'Password'), 'password123');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pumpAndSettle();

    expect(find.text('Enter a valid email'), findsOneWidget);
  });
}
