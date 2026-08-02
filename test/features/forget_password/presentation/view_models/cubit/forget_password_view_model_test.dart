import 'package:bloc_test/bloc_test.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/core/base/base_state.dart';
import 'package:flowery/features/forget_password/data/models/requestes/forget_password_request.dart';
import 'package:flowery/features/forget_password/data/models/requestes/reset_password_request.dart';
import 'package:flowery/features/forget_password/data/models/requestes/verify_reset_password_request.dart';
import 'package:flowery/features/forget_password/data/models/responses/forget_password_response.dart';
import 'package:flowery/features/forget_password/data/models/responses/reset_password_response.dart';
import 'package:flowery/features/forget_password/data/models/responses/verify_email_response.dart';
import 'package:flowery/features/forget_password/domain/use_cases/forget_password_use_case.dart';
import 'package:flowery/features/forget_password/domain/use_cases/reset_password_use_case.dart';
import 'package:flowery/features/forget_password/domain/use_cases/verify_email_use_case.dart';
import 'package:flowery/features/forget_password/presentation/view_models/cubit/forget_password_view_model.dart';
import 'package:flowery/features/forget_password/presentation/view_models/events/forget_password_evente.dart';
import 'package:flowery/features/forget_password/presentation/view_models/states/forget_password_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// ---------------------------------------------------------------------------
// Mocks
// ---------------------------------------------------------------------------

class MockForgetPasswordUseCase extends Mock implements ForgetPasswordUseCase {}

class MockVerifyEmailUseCase extends Mock implements VerifyEmailUseCase {}

class MockResetPasswordUseCase extends Mock implements ResetPasswordUseCase {}

// ---------------------------------------------------------------------------
// Fixtures
// ---------------------------------------------------------------------------

const testEmail = 'test@example.com';
final forgetPasswordRequest = ForgetPasswordRequest(email: testEmail);
final verifyRequest = VerifyResetPasswordRequest(resetCode: '123456');
final resetPasswordRequest = ResetPasswordRequest(password: 'newPass123');

final forgetPasswordResponse = ForgetPasswordResponse(message: 'sent', info: 'ok');
final verifyEmailResponse = VerifyEmailResponse(status: 'verified');
final resetPasswordResponse = ResetPasswordResponse(message: 'done', token: 'tok');

void main() {
  late MockForgetPasswordUseCase sendEmailUseCase;
  late MockVerifyEmailUseCase verifyEmailUseCase;
  late MockResetPasswordUseCase resetPasswordUseCase;

  setUpAll(() {
    registerFallbackValue(ForgetPasswordRequest());
    registerFallbackValue(VerifyResetPasswordRequest());
    registerFallbackValue(ResetPasswordRequest(password: ''));
  });

  setUp(() {
    sendEmailUseCase = MockForgetPasswordUseCase();
    verifyEmailUseCase = MockVerifyEmailUseCase();
    resetPasswordUseCase = MockResetPasswordUseCase();
  });

  ForgetPasswordViewModel buildCubit() => ForgetPasswordViewModel(
        sendEmailUseCase,
        verifyEmailUseCase,
        resetPasswordUseCase,
      );

  // ---------------------------------------------------------------------
  // SendEmailEvent
  // ---------------------------------------------------------------------
  group('SendEmailEvent', () {
    blocTest<ForgetPasswordViewModel, ForgetPasswordState>(
      'emits [loading, success+email, timerStarted] when forgetPassword succeeds',
      setUp: () {
        when(() => sendEmailUseCase.forgetPassword(any())).thenAnswer(
          (_) async => Success(data: forgetPasswordResponse),
        );
      },
      build: buildCubit,
      act: (cubit) => cubit.doIntent(
        event: SendEmailEvent(request: forgetPasswordRequest),
      ),
      // tearDown closes the cubit for us via bloc_test, which cancels the
      // internal Timer, so we don't need to wait for real periodic ticks.
      expect: () => [
        isA<ForgetPasswordState>()
            .having((s) => s.forgetPasswordState.state, 'forgetPasswordState.state', StateType.loading),
        isA<ForgetPasswordState>()
            .having((s) => s.forgetPasswordState.state, 'forgetPasswordState.state', StateType.success)
            .having((s) => s.forgetPasswordState.data, 'forgetPasswordState.data', forgetPasswordResponse)
            .having((s) => s.email, 'email', testEmail),
        isA<ForgetPasswordState>()
            .having((s) => s.isResendEnabled, 'isResendEnabled', false)
            .having((s) => s.timerValue, 'timerValue', 60),
      ],
      verify: (_) {
        verify(() => sendEmailUseCase.forgetPassword(forgetPasswordRequest)).called(1);
      },
    );

    blocTest<ForgetPasswordViewModel, ForgetPasswordState>(
      'emits [loading, error] when forgetPassword fails',
      setUp: () {
        when(() => sendEmailUseCase.forgetPassword(any())).thenAnswer(
          (_) async => Error(exception: Exception('network error')),
        );
      },
      build: buildCubit,
      act: (cubit) => cubit.doIntent(
        event: SendEmailEvent(request: forgetPasswordRequest),
      ),
      expect: () => [
        isA<ForgetPasswordState>()
            .having((s) => s.forgetPasswordState.state, 'forgetPasswordState.state', StateType.loading),
        isA<ForgetPasswordState>()
            .having((s) => s.forgetPasswordState.state, 'forgetPasswordState.state', StateType.error)
            .having((s) => s.email, 'email (unchanged)', null),
      ],
    );
  });

  // ---------------------------------------------------------------------
  // VerifyEmailEvent
  // ---------------------------------------------------------------------
  group('VerifyEmailEvent', () {
    blocTest<ForgetPasswordViewModel, ForgetPasswordState>(
      'emits [loading, success] and clears hasError when verifyEmail succeeds',
      setUp: () {
        when(() => verifyEmailUseCase.verifyEmail(any())).thenAnswer(
          (_) async => Success(data: verifyEmailResponse),
        );
      },
      build: buildCubit,
      seed: () => ForgetPasswordState.initial().copyWith(hasError: true),
      act: (cubit) => cubit.doIntent(
        event: VerifyEmailEvent(request: verifyRequest),
      ),
      expect: () => [
        isA<ForgetPasswordState>()
            .having((s) => s.hasError, 'hasError', false)
            .having((s) => s.verifyEmailState.state, 'verifyEmailState.state', StateType.loading),
        isA<ForgetPasswordState>()
            .having((s) => s.verifyEmailState.state, 'verifyEmailState.state', StateType.success)
            .having((s) => s.verifyEmailState.data, 'verifyEmailState.data', verifyEmailResponse),
      ],
    );

    blocTest<ForgetPasswordViewModel, ForgetPasswordState>(
      'emits [loading, error] and resets otp when verifyEmail fails',
      setUp: () {
        when(() => verifyEmailUseCase.verifyEmail(any())).thenAnswer(
          (_) async => Error(exception: Exception('invalid code')),
        );
      },
      build: buildCubit,
      seed: () => ForgetPasswordState.initial().copyWith(
        otpValue: '123456',
        otpResetKey: 0,
      ),
      act: (cubit) => cubit.doIntent(
        event: VerifyEmailEvent(request: verifyRequest),
      ),
      expect: () => [
        isA<ForgetPasswordState>()
            .having((s) => s.verifyEmailState.state, 'verifyEmailState.state', StateType.loading),
        isA<ForgetPasswordState>()
            .having((s) => s.hasError, 'hasError', true)
            .having((s) => s.otpValue, 'otpValue', '')
            .having((s) => s.otpResetKey, 'otpResetKey', 1)
            .having((s) => s.verifyEmailState.state, 'verifyEmailState.state', StateType.error),
      ],
    );
  });

  // ---------------------------------------------------------------------
  // UpdateOtpEvent
  // ---------------------------------------------------------------------
  group('UpdateOtpEvent', () {
    blocTest<ForgetPasswordViewModel, ForgetPasswordState>(
      'only updates otpValue when otp length < 6 (does not call verifyEmail)',
      build: buildCubit,
      act: (cubit) => cubit.doIntent(event: UpdateOtpEvent(otp: '123')),
      expect: () => [
        isA<ForgetPasswordState>()
            .having((s) => s.otpValue, 'otpValue', '123')
            .having((s) => s.hasError, 'hasError', false),
      ],
      verify: (_) {
        verifyNever(() => verifyEmailUseCase.verifyEmail(any()));
      },
    );

    blocTest<ForgetPasswordViewModel, ForgetPasswordState>(
      'triggers verifyEmail automatically when otp reaches 6 digits',
      setUp: () {
        when(() => verifyEmailUseCase.verifyEmail(any())).thenAnswer(
          (_) async => Success(data: verifyEmailResponse),
        );
      },
      build: buildCubit,
      act: (cubit) => cubit.doIntent(event: UpdateOtpEvent(otp: '654321')),
      expect: () => [
        isA<ForgetPasswordState>()
            .having((s) => s.otpValue, 'otpValue', '654321')
            .having((s) => s.hasError, 'hasError', false),
        isA<ForgetPasswordState>()
            .having((s) => s.verifyEmailState.state, 'verifyEmailState.state', StateType.loading),
        isA<ForgetPasswordState>()
            .having((s) => s.verifyEmailState.state, 'verifyEmailState.state', StateType.success),
      ],
      verify: (_) {
        verify(
          () => verifyEmailUseCase.verifyEmail(
            any(that: isA<VerifyResetPasswordRequest>()),
          ),
        ).called(1);
      },
    );
  });

  // ---------------------------------------------------------------------
  // ResetPasswordEvent
  // ---------------------------------------------------------------------
  group('ResetPasswordEvent', () {
    blocTest<ForgetPasswordViewModel, ForgetPasswordState>(
      'emits nothing and does not call resetPassword when email is null',
      build: buildCubit,
      act: (cubit) => cubit.doIntent(
        event: ResetPasswordEvent(request: resetPasswordRequest),
      ),
      expect: () => [],
      verify: (_) {
        verifyNever(() => resetPasswordUseCase.resetPassword(any()));
      },
    );

    blocTest<ForgetPasswordViewModel, ForgetPasswordState>(
      'emits [loading, success] using saved email when resetPassword succeeds',
      setUp: () {
        when(() => resetPasswordUseCase.resetPassword(any())).thenAnswer(
          (_) async => Success(data: resetPasswordResponse),
        );
      },
      build: buildCubit,
      seed: () => ForgetPasswordState.initial().copyWith(email: testEmail),
      act: (cubit) => cubit.doIntent(
        event: ResetPasswordEvent(request: resetPasswordRequest),
      ),
      expect: () => [
        isA<ForgetPasswordState>()
            .having((s) => s.resetPasswordState.state, 'resetPasswordState.state', StateType.loading),
        isA<ForgetPasswordState>()
            .having((s) => s.resetPasswordState.state, 'resetPasswordState.state', StateType.success)
            .having((s) => s.resetPasswordState.data, 'resetPasswordState.data', resetPasswordResponse),
      ],
      verify: (_) {
        final captured = verify(
          () => resetPasswordUseCase.resetPassword(captureAny()),
        ).captured;
        final sentRequest = captured.single as ResetPasswordRequest;
        expect(sentRequest.email, testEmail);
        expect(sentRequest.password, resetPasswordRequest.password);
      },
    );

    blocTest<ForgetPasswordViewModel, ForgetPasswordState>(
      'emits [loading, error] when resetPassword fails',
      setUp: () {
        when(() => resetPasswordUseCase.resetPassword(any())).thenAnswer(
          (_) async => Error(exception: Exception('reset failed')),
        );
      },
      build: buildCubit,
      seed: () => ForgetPasswordState.initial().copyWith(email: testEmail),
      act: (cubit) => cubit.doIntent(
        event: ResetPasswordEvent(request: resetPasswordRequest),
      ),
      expect: () => [
        isA<ForgetPasswordState>()
            .having((s) => s.resetPasswordState.state, 'resetPasswordState.state', StateType.loading),
        isA<ForgetPasswordState>()
            .having((s) => s.resetPasswordState.state, 'resetPasswordState.state', StateType.error),
      ],
    );
  });

  // ---------------------------------------------------------------------
  // OTP resend timer (controlled clock via fake_async)
  // ---------------------------------------------------------------------
  group('OTP resend timer', () {
    test('counts down from 60 to 0 then enables resend, one tick per second', () {
      when(() => sendEmailUseCase.forgetPassword(any())).thenAnswer(
        (_) async => Success(data: forgetPasswordResponse),
      );

      fakeAsync((async) {
        final cubit = buildCubit();

        cubit.doIntent(event: SendEmailEvent(request: forgetPasswordRequest));
        // Flush the async use-case call (loading -> success -> timer start).
        async.flushMicrotasks();

        expect(cubit.state.timerValue, 60);
        expect(cubit.state.isResendEnabled, false);

        // Advance 30 seconds.
        async.elapse(const Duration(seconds: 30));
        expect(cubit.state.timerValue, 30);
        expect(cubit.state.isResendEnabled, false);

        // Advance the remaining 30 seconds. The periodic callback checks
        // state.timerValue == 0 at the START of each tick, so timerValue
        // reaches 0 on tick 60, but isResendEnabled only flips true on the
        // NEXT tick (61) once the callback sees timerValue == 0.
        async.elapse(const Duration(seconds: 30));
        expect(cubit.state.timerValue, 0);
        expect(cubit.state.isResendEnabled, false);

        // One more tick to let the callback observe timerValue == 0 and
        // cancel itself.
        async.elapse(const Duration(seconds: 1));
        expect(cubit.state.timerValue, 0);
        expect(cubit.state.isResendEnabled, true);

        // Timer should have cancelled itself; further elapsed time must not
        // push timerValue negative or re-toggle isResendEnabled.
        async.elapse(const Duration(seconds: 5));
        expect(cubit.state.timerValue, 0);
        expect(cubit.state.isResendEnabled, true);

        cubit.close();
      });
    });

    test('close() cancels the timer so no further emits occur', () {
      when(() => sendEmailUseCase.forgetPassword(any())).thenAnswer(
        (_) async => Success(data: forgetPasswordResponse),
      );

      fakeAsync((async) {
        final cubit = buildCubit();

        cubit.doIntent(event: SendEmailEvent(request: forgetPasswordRequest));
        async.flushMicrotasks();

        expect(cubit.state.timerValue, 60);

        cubit.close();

        // Advancing time after close must not throw or change state.
        async.elapse(const Duration(seconds: 10));
        expect(cubit.state.timerValue, 60);
      });
    });
  });
}