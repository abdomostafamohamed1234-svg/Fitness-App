import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:bloc_test/bloc_test.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/base/base_state.dart';
import 'package:flowery/features/forget_password/data/models/requestes/forget_password_request.dart';
import 'package:flowery/features/forget_password/data/models/requestes/verify_reset_password_request.dart';
import 'package:flowery/features/forget_password/data/models/responses/verify_email_response.dart';
// NOTE: adjust these imports if the real file locations differ.
import 'package:flowery/features/forget_password/presentation/screens/create_password_screen.dart';
import 'package:flowery/features/forget_password/presentation/screens/otp_screen.dart';
import 'package:flowery/features/forget_password/presentation/view_models/cubit/forget_password_view_model.dart';
import 'package:flowery/features/forget_password/presentation/view_models/events/forget_password_evente.dart';
import 'package:flowery/features/forget_password/presentation/view_models/states/forget_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// ---------------------------------------------------------------------------
// Mocks
// ---------------------------------------------------------------------------

class MockForgetPasswordViewModel extends MockCubit<ForgetPasswordState>
    implements ForgetPasswordViewModel {}

// ---------------------------------------------------------------------------
// Test asset stubbing (same approach as the other screen tests).
// ---------------------------------------------------------------------------

final Uint8List _fakePngBytes = Uint8List.fromList([
  0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D,
  0x49, 0x48, 0x44, 0x52, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01,
  0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4, 0x89, 0x00, 0x00, 0x00,
  0x0A, 0x49, 0x44, 0x41, 0x54, 0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00,
  0x05, 0x00, 0x01, 0x0D, 0x0A, 0x2D, 0xB4, 0x00, 0x00, 0x00, 0x00, 0x49,
  0x45, 0x4E, 0x44, 0xAE, 0x42, 0x60, 0x82,
]);

String _decodeAssetKey(ByteData? message) {
  if (message == null) return '';
  try {
    const codec = StandardMessageCodec();
    final decoded = codec.decodeMessage(message);
    if (decoded is String) return decoded;
  } catch (_) {
    // Fall through to the raw-utf8 format used by older Flutter versions.
  }
  return utf8.decode(
    message.buffer.asUint8List(message.offsetInBytes, message.lengthInBytes),
  );
}

void _stubAssetBundle() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final messenger = TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;

  messenger.setMockMessageHandler('flutter/assets', (ByteData? message) async {
    final key = _decodeAssetKey(message);

    if (key == 'AssetManifest.json') {
      return utf8.encoder.convert('{}').buffer.asByteData();
    }
    if (key == 'AssetManifest.bin' || key == 'AssetManifest.smcbin') {
      const codec = StandardMessageCodec();
      return codec.encodeMessage(<Object?, Object?>{});
    }
    if (key == 'FontManifest.json') {
      return utf8.encoder.convert('[]').buffer.asByteData();
    }

    return _fakePngBytes.buffer.asByteData();
  });
}

// ---------------------------------------------------------------------------
// Fixtures
// ---------------------------------------------------------------------------

ForgetPasswordState stateWith({
  String? email,
  int timerValue = 0,
  bool isResendEnabled = true,
  bool hasError = false,
  String otpValue = '',
  int otpResetKey = 0,
  BaseState<VerifyEmailResponse>? verifyEmailState,
}) {
  return ForgetPasswordState.initial().copyWith(
    email: email,
    timerValue: timerValue,
    isResendEnabled: isResendEnabled,
    hasError: hasError,
    otpValue: otpValue,
    otpResetKey: otpResetKey,
    verifyEmailState:
        verifyEmailState ?? const BaseState<VerifyEmailResponse>.initial(),
  );
}

// ---------------------------------------------------------------------------
// Test harness
// ---------------------------------------------------------------------------

Widget makeTestableWidget({required ForgetPasswordViewModel cubit}) {
  return ScreenUtilInit(
    designSize: const Size(375, 812),
    minTextAdapt: true,
    builder: (context, _) => MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider<ForgetPasswordViewModel>.value(
        value: cubit,
        child: const OtpScreen(),
      ),
    ),
  );
}

void main() {
  late MockForgetPasswordViewModel mockCubit;

  setUpAll(() {
    registerFallbackValue(UpdateOtpEvent(otp: ''));
  });

  setUp(() {
    _stubAssetBundle();
    mockCubit = MockForgetPasswordViewModel();
    when(() => mockCubit.doIntent(event: any(named: 'event')))
        .thenAnswer((_) async {});
  });

  Future<void> pumpScreen(
    WidgetTester tester, {
    ForgetPasswordState? initialState,
  }) async {
    whenListen(
      mockCubit,
      const Stream<ForgetPasswordState>.empty(),
      initialState: initialState ?? stateWith(),
    );
    await tester.pumpWidget(makeTestableWidget(cubit: mockCubit));
    await tester.pumpAndSettle();
  }

  group('Rendering', () {
    testWidgets('shows title, subtitle, 6 otp boxes, disabled Confirm and resend text',
        (tester) async {
      await pumpScreen(tester);

      expect(find.text('OTP CODE'), findsOneWidget);
      expect(find.text('Enter Your OTP Check Your Email'), findsOneWidget);
      expect(find.byType(TextField), findsNWidgets(6));
      expect(find.widgetWithText(ElevatedButton, 'Confirm'), findsOneWidget);
      expect(find.text("Didn't Receive Verification Code?"), findsOneWidget);
      expect(find.text('Resend Code?'), findsOneWidget);

      final confirmButton =
          tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(confirmButton.onPressed, isNull, reason: 'otp is empty initially');
    });
  });

  group('OTP entry', () {
    testWidgets('typing a digit in each box calls doIntent with the cumulative otp',
        (tester) async {
      await pumpScreen(tester);

      final fields = find.byType(TextField);
      const digits = ['1', '2', '3', '4', '5', '6'];

      for (var i = 0; i < digits.length; i++) {
        await tester.enterText(fields.at(i), digits[i]);
        await tester.pump();
      }

      final captured = verify(
        () => mockCubit.doIntent(event: captureAny(named: 'event')),
      ).captured;

      // One UpdateOtpEvent per keystroke.
      expect(captured.length, 6);
      for (final call in captured) {
        expect(call, isA<UpdateOtpEvent>());
      }

      final lastEvent = captured.last as UpdateOtpEvent;
      expect(lastEvent.otp, '123456');
    });
  });

  group('Error message', () {
    testWidgets('shows the invalid-code message only when hasError is true',
        (tester) async {
      await pumpScreen(tester, initialState: stateWith(hasError: false));
      expect(find.text('Invalid code, please try again'), findsNothing);
    });

    testWidgets('shows invalid-code message when hasError becomes true',
        (tester) async {
      final controller = StreamController<ForgetPasswordState>();
      addTearDown(controller.close);

      whenListen(mockCubit, controller.stream, initialState: stateWith());
      await tester.pumpWidget(makeTestableWidget(cubit: mockCubit));
      await tester.pumpAndSettle();

      controller.add(stateWith(hasError: true));
      await tester.pump();
      await tester.pump();

      expect(find.text('Invalid code, please try again'), findsOneWidget);
    });
  });

  group('Confirm button', () {
    testWidgets('is enabled once otp reaches 6 digits and calls doIntent with VerifyEmailEvent',
        (tester) async {
      await pumpScreen(tester, initialState: stateWith(otpValue: '123456'));

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNotNull);

      await tester.tap(find.widgetWithText(ElevatedButton, 'Confirm'));
      await tester.pump();

      final captured = verify(
        () => mockCubit.doIntent(event: captureAny(named: 'event')),
      ).captured;

      expect(captured.single, isA<VerifyEmailEvent>());
      final event = captured.single as VerifyEmailEvent;
      expect(event.request.resetCode, '123456');
    });

    testWidgets('shows spinner and is disabled while verifyEmailState is loading',
        (tester) async {
      whenListen(
        mockCubit,
        const Stream<ForgetPasswordState>.empty(),
        initialState: stateWith(
          otpValue: '123456',
          verifyEmailState: const BaseState<VerifyEmailResponse>.loading(),
        ),
      );
      await tester.pumpWidget(makeTestableWidget(cubit: mockCubit));
      // Don't use pumpAndSettle here: the CircularProgressIndicator animates
      // indefinitely and pumpAndSettle would time out waiting for it to
      // stop. A couple of explicit pumps is enough to build the frame.
      await tester.pump();
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Confirm'), findsNothing);

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNull);
    });
  });

  group('Resend code', () {
    testWidgets('shows "Resend Code?" and calls doIntent with a SendEmailEvent using the saved email',
        (tester) async {
      await pumpScreen(
        tester,
        initialState: stateWith(email: 'saved@example.com', isResendEnabled: true),
      );

      expect(find.text('Resend Code?'), findsOneWidget);

      await tester.tap(find.text('Resend Code?'));
      await tester.pump();

      final captured = verify(
        () => mockCubit.doIntent(event: captureAny(named: 'event')),
      ).captured;

      expect(captured.single, isA<SendEmailEvent>());
      final event = captured.single as SendEmailEvent;
      expect(event.request.email, 'saved@example.com');
    });

    testWidgets('shows the countdown and disables the button while isResendEnabled is false',
        (tester) async {
      await pumpScreen(
        tester,
        initialState: stateWith(isResendEnabled: false, timerValue: 45),
      );

      expect(find.text('Resend Code in 45s'), findsOneWidget);
      expect(find.text('Resend Code?'), findsNothing);

      final resendButton = tester.widget<TextButton>(find.byType(TextButton));
      expect(resendButton.onPressed, isNull);
    });
  });

  group('BlocListener side effects', () {
    testWidgets('navigates to CreatePasswordScreen when verifyEmailState succeeds',
        (tester) async {
      final controller = StreamController<ForgetPasswordState>();
      addTearDown(controller.close);

      whenListen(mockCubit, controller.stream, initialState: stateWith());
      await tester.pumpWidget(makeTestableWidget(cubit: mockCubit));
      await tester.pumpAndSettle();

      expect(find.byType(OtpScreen), findsOneWidget);
      expect(find.byType(CreatePasswordScreen), findsNothing);

      controller.add(
        stateWith(
          verifyEmailState:
              BaseState<VerifyEmailResponse>.success(VerifyEmailResponse(status: 'ok')),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(CreatePasswordScreen), findsOneWidget);
    });

    testWidgets('shows a SnackBar with the error message when verifyEmailState fails',
        (tester) async {
      final controller = StreamController<ForgetPasswordState>();
      addTearDown(controller.close);

      whenListen(mockCubit, controller.stream, initialState: stateWith());
      await tester.pumpWidget(makeTestableWidget(cubit: mockCubit));
      await tester.pumpAndSettle();

      controller.add(
        stateWith(
          verifyEmailState: BaseState<VerifyEmailResponse>.error(
            Exception('invalid code'),
          ),
        ),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Exception: invalid code'), findsOneWidget);
    });
  });
}