import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/features/change_password/presentation/events/change_password_events.dart';
import 'package:flowery/features/change_password/presentation/screens/change_password_screen.dart';
import 'package:flowery/features/change_password/presentation/states/change_password_states.dart';
import 'package:flowery/features/change_password/presentation/view_model/change_password_view_model.dart';
import 'package:flowery/features/change_password/presentation/widgets/done_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Adjust this import if ChangePasswordScreen lives elsewhere in your project.

class MockChangePasswordViewModel extends MockCubit<ChangePasswordState>
    implements ChangePasswordViewModel {}

void main() {
  late MockChangePasswordViewModel mockCubit;

  setUpAll(() {
    // ChangePasswordEvents is sealed, so we register a concrete subtype
    // as the fallback value instead of a Fake.
    registerFallbackValue(ToggleOldPasswordVisibility());
  });

  setUp(() {
    mockCubit = MockChangePasswordViewModel();
    when(() => mockCubit.state).thenReturn(const ChangePasswordState());
  });

  Widget buildTestWidget() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider<ChangePasswordViewModel>.value(
        value: mockCubit,
        child: const ChangePasswordScreen(),
      ),
    );
  }

  group('ChangePasswordScreen', () {
    testWidgets('renders header, 3 password fields and done button', (
      tester,
    ) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(TextField), findsNWidgets(3));
      expect(find.byType(DoneButton), findsOneWidget);
      // All fields start obscured (isXVisible defaults to false).
      expect(find.byIcon(Icons.visibility_off_outlined), findsNWidgets(3));
      expect(find.byIcon(Icons.visibility_outlined), findsNothing);
    });

    testWidgets(
      'tapping the first visibility toggle dispatches ToggleOldPasswordVisibility',
      (tester) async {
        await tester.pumpWidget(buildTestWidget());
        await tester.pump();

        await tester.tap(find.byIcon(Icons.visibility_off_outlined).first);
        await tester.pump();

        verify(
          () => mockCubit.doEvent(
            any(that: isA<ToggleOldPasswordVisibility>()),
          ),
        ).called(1);
      },
    );

    testWidgets(
      'tapping the second and third toggles dispatch the matching events',
      (tester) async {
        await tester.pumpWidget(buildTestWidget());
        await tester.pump();

        final toggles = find.byIcon(Icons.visibility_off_outlined);

        await tester.tap(toggles.at(1));
        await tester.pump();
        verify(
          () => mockCubit.doEvent(
            any(that: isA<ToggleNewPasswordVisibility>()),
          ),
        ).called(1);

        await tester.tap(toggles.at(2));
        await tester.pump();
        verify(
          () => mockCubit.doEvent(
            any(that: isA<ToggleConfirmPasswordVisibility>()),
          ),
        ).called(1);
      },
    );

    testWidgets(
      'tapping done dispatches UpdatePasswordEvent with entered text',
      (tester) async {
        await tester.pumpWidget(buildTestWidget());
        await tester.pump();

        final fields = find.byType(TextField);
        await tester.enterText(fields.at(0), 'oldPass123');
        await tester.enterText(fields.at(1), 'newPass456');
        await tester.enterText(fields.at(2), 'newPass456');
        await tester.pump();

        await tester.tap(find.byType(ElevatedButton));
        await tester.pump();

        final captured = verify(
          () => mockCubit.doEvent(captureAny()),
        ).captured;
        final event = captured.last as UpdatePasswordEvent;
        expect(event.password, 'oldPass123');
        expect(event.newPassword, 'newPass456');
      },
    );

    testWidgets('shows spinner and disables button when isLoading is true', (
      tester,
    ) async {
      when(
        () => mockCubit.state,
      ).thenReturn(const ChangePasswordState(isLoading: true));

      await tester.pumpWidget(buildTestWidget());
      // Avoid pumpAndSettle: CircularProgressIndicator animates indefinitely.
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      final button = tester.widget<ElevatedButton>(
        find.byType(ElevatedButton),
      );
      expect(button.onPressed, isNull);
    });

    testWidgets(
      'does not dispatch an event when tapping done while loading (button disabled)',
      (tester) async {
        when(
          () => mockCubit.state,
        ).thenReturn(const ChangePasswordState(isLoading: true));

        await tester.pumpWidget(buildTestWidget());
        await tester.pump();

        await tester.tap(find.byType(ElevatedButton), warnIfMissed: false);
        await tester.pump();

        verifyNever(() => mockCubit.doEvent(any()));
      },
    );

    testWidgets(
      'shows a SnackBar with the message when state becomes done with a message',
      (tester) async {
        final controller = StreamController<ChangePasswordState>();
        addTearDown(controller.close);

        whenListen(
          mockCubit,
          controller.stream,
          initialState: const ChangePasswordState(),
        );

        await tester.pumpWidget(buildTestWidget());
        await tester.pump();

        const message = 'Password changed successfully';
        controller.add(
          const ChangePasswordState(isDone: true, message: message),
        );
        // First pump: listener fires and calls ScaffoldMessenger.showSnackBar.
        await tester.pump();
        // Second pump: lets the SnackBar's entrance animation build into the tree.
        await tester.pump();

        expect(find.text(message), findsOneWidget);
      },
    );

    testWidgets(
      'does not show a SnackBar when isDone is true but message is null',
      (tester) async {
        final controller = StreamController<ChangePasswordState>();
        addTearDown(controller.close);

        whenListen(
          mockCubit,
          controller.stream,
          initialState: const ChangePasswordState(),
        );

        await tester.pumpWidget(buildTestWidget());
        await tester.pump();

        controller.add(const ChangePasswordState(isDone: true));
        await tester.pump();

        expect(find.byType(SnackBar), findsNothing);
      },
    );
  });
}