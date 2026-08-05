import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:bloc_test/bloc_test.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/core/base/base_state.dart';
import 'package:flowery/features/forget_password/data/models/requestes/forget_password_request.dart';
import 'package:flowery/features/forget_password/data/models/responses/forget_password_response.dart';
import 'package:flowery/features/forget_password/presentation/screens/otp_screen.dart';
// NOTE: adjust this import to match the real location of ForgetPasswordScreen
// in your project if it differs.
import 'package:flowery/features/forget_password/presentation/screens/forget_password_screen.dart';
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
// Test asset stubbing (see create_password_screen_test.dart for why this is
// needed and why the key must be decoded via StandardMessageCodec first).
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

const validEmail = 'test@example.com';

ForgetPasswordState stateWith({
  BaseState<ForgetPasswordResponse>? forgetPasswordState,
}) {
  return ForgetPasswordState.initial().copyWith(
    forgetPasswordState:
        forgetPasswordState ?? const BaseState<ForgetPasswordResponse>.initial(),
  );
}

// ---------------------------------------------------------------------------
// Test harness
// ---------------------------------------------------------------------------

Widget makeTestableWidget({
  required ForgetPasswordViewModel cubit,
  GlobalKey<NavigatorState>? navigatorKey,
}) {
  return ScreenUtilInit(
    designSize: const Size(375, 812),
    minTextAdapt: true,
    builder: (context, _) => MaterialApp(
      navigatorKey: navigatorKey,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider<ForgetPasswordViewModel>.value(
        value: cubit,
        child: const ForgetPasswordScreen(),
      ),
    ),
  );
}

void main() {
  late MockForgetPasswordViewModel mockCubit;

  setUpAll(() {
    registerFallbackValue(
      SendEmailEvent(request: ForgetPasswordRequest(email: '')),
    );
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
    GlobalKey<NavigatorState>? navigatorKey,
  }) async {
    whenListen(
      mockCubit,
      const Stream<ForgetPasswordState>.empty(),
      initialState: initialState ?? stateWith(),
    );
    await tester.pumpWidget(
      makeTestableWidget(cubit: mockCubit, navigatorKey: navigatorKey),
    );
    await tester.pumpAndSettle();
  }

  group('Rendering', () {
    testWidgets('shows title, subtitle, email field and Sent Otp button',
        (tester) async {
      await pumpScreen(tester);

      expect(find.text('Enter Your Email'), findsOneWidget);
      // "Forget Password" appears both in the AppBar title and the body
      // heading, so expect two matches.
      expect(find.text('Forget Password'), findsNWidgets(2));
      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.widgetWithText(ElevatedButton, 'Sent Otp'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });
  });

  group('Validation', () {
    testWidgets('shows error and does not call doIntent when email is empty',
        (tester) async {
      await pumpScreen(tester);

      await tester.tap(find.widgetWithText(ElevatedButton, 'Sent Otp'));
      await tester.pumpAndSettle();

      expect(find.text('Please enter a valid email'), findsOneWidget);
      verifyNever(() => mockCubit.doIntent(event: any(named: 'event')));
    });

    testWidgets('shows error and does not call doIntent when email format is invalid',
        (tester) async {
      await pumpScreen(tester);

      await tester.enterText(find.byType(TextFormField), 'not-an-email');
      await tester.tap(find.widgetWithText(ElevatedButton, 'Sent Otp'));
      await tester.pumpAndSettle();

      expect(find.text('Please enter a valid email'), findsOneWidget);
      verifyNever(() => mockCubit.doIntent(event: any(named: 'event')));
    });

    testWidgets('calls doIntent with a trimmed SendEmailEvent when email is valid',
        (tester) async {
      await pumpScreen(tester);

      await tester.enterText(find.byType(TextFormField), '  $validEmail  ');
      await tester.tap(find.widgetWithText(ElevatedButton, 'Sent Otp'));
      await tester.pumpAndSettle();

      final captured = verify(
        () => mockCubit.doIntent(event: captureAny(named: 'event')),
      ).captured;

      expect(captured.single, isA<SendEmailEvent>());
      final event = captured.single as SendEmailEvent;
      expect(event.request.email, validEmail);
    });
  });

  group('Loading state', () {
    testWidgets('shows spinner and disables the button while forgetPasswordState is loading',
        (tester) async {
      final controller = StreamController<ForgetPasswordState>();
      addTearDown(controller.close);

      whenListen(
        mockCubit,
        controller.stream,
        initialState: stateWith(),
      );

      await tester.pumpWidget(makeTestableWidget(cubit: mockCubit));
      await tester.pumpAndSettle();

      controller.add(
        stateWith(
          forgetPasswordState: const BaseState<ForgetPasswordResponse>.loading(),
        ),
      );
      // Two pumps: one to flush the microtask that delivers the stream
      // event through whenListen's forwarding controller, one to rebuild.
      await tester.pump();
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Sent Otp'), findsNothing);

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNull);
    });
  });

  group('BlocListener side effects', () {
    testWidgets('navigates to OtpScreen when forgetPasswordState succeeds',
        (tester) async {
      final controller = StreamController<ForgetPasswordState>();
      addTearDown(controller.close);

      whenListen(
        mockCubit,
        controller.stream,
        initialState: stateWith(),
      );

      await tester.pumpWidget(makeTestableWidget(cubit: mockCubit));
      await tester.pumpAndSettle();

      expect(find.byType(ForgetPasswordScreen), findsOneWidget);
      expect(find.byType(OtpScreen), findsNothing);

      controller.add(
        stateWith(
          forgetPasswordState: BaseState<ForgetPasswordResponse>.success(
            ForgetPasswordResponse(message: 'sent', info: 'ok'),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(OtpScreen), findsOneWidget);
    });

    testWidgets('shows a SnackBar with the error message when forgetPasswordState fails',
        (tester) async {
      final controller = StreamController<ForgetPasswordState>();
      addTearDown(controller.close);

      whenListen(
        mockCubit,
        controller.stream,
        initialState: stateWith(),
      );

      await tester.pumpWidget(makeTestableWidget(cubit: mockCubit));
      await tester.pumpAndSettle();

      controller.add(
        stateWith(
          forgetPasswordState: BaseState<ForgetPasswordResponse>.error(
            Exception('network error'),
          ),
        ),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Exception: network error'), findsOneWidget);
    });
  });
}