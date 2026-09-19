import 'dart:async';
import 'dart:convert';
import 'package:bloc_test/bloc_test.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/base/base_state.dart';
import 'package:flowery/features/forget_password/data/models/requestes/reset_password_request.dart';
import 'package:flowery/features/forget_password/data/models/responses/reset_password_response.dart';
import 'package:flowery/features/forget_password/presentation/view_models/cubit/forget_password_view_model.dart';
import 'package:flowery/features/forget_password/presentation/view_models/events/forget_password_evente.dart';
import 'package:flowery/features/forget_password/presentation/view_models/states/forget_password_state.dart';
// NOTE: adjust this import to match the real location of CreatePasswordScreen
// in your project if it differs.
import 'package:flowery/features/forget_password/presentation/screens/create_password_screen.dart';
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
// Test asset stubbing
//
// AuthBackgroundScaffold renders Image.asset('assets/on_boarding_background.jpg').
// The widget-test binding has no real asset bundle, so without this the image
// load fails and pollutes/fails the test with "Unable to load asset".
// We stub the 'flutter/assets' platform channel to return a tiny valid PNG
// for any requested key.
// ---------------------------------------------------------------------------

// 1x1 transparent PNG.
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
  // Newer Flutter versions send the asset key StandardMessageCodec-encoded
  // over the 'flutter/assets' channel. Try that first.
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

    // Any other asset (our background image, etc.) -> fake PNG bytes.
    return _fakePngBytes.buffer.asByteData();
  });
}

// ---------------------------------------------------------------------------
// Fixtures
// ---------------------------------------------------------------------------

const validPassword = 'StrongPass1';

ForgetPasswordState stateWith({
  String? email = 'test@example.com',
  BaseState<ResetPasswordResponse>? resetPasswordState,
}) {
  return ForgetPasswordState.initial().copyWith(
    email: email,
    resetPasswordState:
        resetPasswordState ?? const BaseState<ResetPasswordResponse>.initial(),
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
        child: const CreatePasswordScreen(),
      ),
    ),
  );
}

void main() {
  late MockForgetPasswordViewModel mockCubit;

  setUpAll(() {
    registerFallbackValue(
      ResetPasswordEvent(request: ResetPasswordRequest(password: '')),
    );
  });

  setUp(() {
    _stubAssetBundle();
    mockCubit = MockForgetPasswordViewModel();
    // Default stub: doIntent resolves immediately and does nothing extra.
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
    testWidgets('shows title, hint copy, both password fields and Done button',
        (tester) async {
      await pumpScreen(tester);

      expect(find.text('Create New Password'), findsOneWidget);
      expect(find.text('Make Sure Its 8 Characters Or More'), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.widgetWithText(ElevatedButton, 'Done'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });
  });

  group('Password visibility toggles', () {
    testWidgets('tapping the eye icon toggles obscureText on password field',
        (tester) async {
      await pumpScreen(tester);

      // Initially obscured -> "visibility_off" icon shown.
      expect(find.byIcon(Icons.visibility_off_outlined), findsNWidgets(2));
      expect(find.byIcon(Icons.visibility_outlined), findsNothing);

      await tester.tap(find.byIcon(Icons.visibility_off_outlined).first);
      await tester.pump();

      expect(find.byIcon(Icons.visibility_outlined), findsOneWidget);
      expect(find.byIcon(Icons.visibility_off_outlined), findsOneWidget);
    });
  });

  group('Validation', () {
    testWidgets('shows error and does not call doIntent when password is too short',
        (tester) async {
      await pumpScreen(tester);

      final fields = find.byType(TextFormField);
      await tester.enterText(fields.at(0), 'short');
      await tester.enterText(fields.at(1), 'short');

      await tester.tap(find.widgetWithText(ElevatedButton, 'Done'));
      await tester.pumpAndSettle();

      expect(find.text('Password must be 8 characters or more'), findsOneWidget);
      verifyNever(() => mockCubit.doIntent(event: any(named: 'event')));
    });

    testWidgets('shows error and does not call doIntent when passwords do not match',
        (tester) async {
      await pumpScreen(tester);

      final fields = find.byType(TextFormField);
      await tester.enterText(fields.at(0), validPassword);
      await tester.enterText(fields.at(1), 'DifferentPass1');

      await tester.tap(find.widgetWithText(ElevatedButton, 'Done'));
      await tester.pumpAndSettle();

      expect(find.text('Password do not match'), findsOneWidget);
      verifyNever(() => mockCubit.doIntent(event: any(named: 'event')));
    });

    testWidgets('calls doIntent with ResetPasswordEvent when form is valid',
        (tester) async {
      await pumpScreen(tester);

      final fields = find.byType(TextFormField);
      await tester.enterText(fields.at(0), validPassword);
      await tester.enterText(fields.at(1), validPassword);

      await tester.tap(find.widgetWithText(ElevatedButton, 'Done'));
      await tester.pumpAndSettle();

      final captured = verify(
        () => mockCubit.doIntent(event: captureAny(named: 'event')),
      ).captured;

      expect(captured.single, isA<ResetPasswordEvent>());
      final event = captured.single as ResetPasswordEvent;
      expect(event.request.password, validPassword);
    });
  });

  group('Loading state', () {
    testWidgets('shows spinner and disables Done button while resetPasswordState is loading',
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
          resetPasswordState: const BaseState<ResetPasswordResponse>.loading(),
        ),
      );
      // Two pumps: one to flush the microtask that delivers the stream
      // event through whenListen's forwarding controller, one to rebuild.
      await tester.pump();
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Done'), findsNothing);

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNull);
    });
  });

  group('BlocListener side effects', () {
    testWidgets('pops back to the first route when resetPasswordState succeeds',
        (tester) async {
      final controller = StreamController<ForgetPasswordState>();
      addTearDown(controller.close);

      whenListen(
        mockCubit,
        controller.stream,
        initialState: stateWith(),
      );

      final navigatorKey = GlobalKey<NavigatorState>();

      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, _) => MaterialApp(
            navigatorKey: navigatorKey,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const Scaffold(body: Text('Login Screen')),
          ),
        ),
      );
      await tester.pumpAndSettle();

      navigatorKey.currentState!.push(
        MaterialPageRoute(
          builder: (_) => BlocProvider<ForgetPasswordViewModel>.value(
            value: mockCubit,
            child: const CreatePasswordScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Create New Password'), findsOneWidget);
      expect(find.text('Login Screen'), findsNothing);

      controller.add(
        stateWith(
          resetPasswordState:
              BaseState<ResetPasswordResponse>.success(ResetPasswordResponse()),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Login Screen'), findsOneWidget);
      expect(find.text('Create New Password'), findsNothing);
    });

    testWidgets('shows a SnackBar with the error message when resetPasswordState fails',
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
          resetPasswordState: BaseState<ResetPasswordResponse>.error(
            Exception('reset failed'),
          ),
        ),
      );
      await tester.pump(); // build the SnackBar
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Exception: reset failed'), findsOneWidget);
    });
  });
}