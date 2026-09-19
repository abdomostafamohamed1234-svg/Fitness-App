import 'package:bloc_test/bloc_test.dart';
import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/change_password/domain/entities/change_password_response_entity.dart';
import 'package:flowery/features/change_password/domain/ues_case/change_password_use_case.dart';
import 'package:flowery/features/change_password/presentation/events/change_password_events.dart';
import 'package:flowery/features/change_password/presentation/states/change_password_states.dart';
import 'package:flowery/features/change_password/presentation/view_model/change_password_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';



class MockChangePasswordUseCase extends Mock implements ChangePasswordUseCase {}

void main() {
  late MockChangePasswordUseCase mockUseCase;
  late ChangePasswordViewModel viewModel;

  setUpAll(() {
    // Needed because mocktail requires a registered fallback for any()/captureAny()
    // matchers used with a custom type - not strictly required here since we use
    // literal values, but kept as a safe default matching your other test files.
    registerFallbackValue(
      const ChangePasswordResponseEntity(message: 'fallback'),
    );
  });

  setUp(() {
    mockUseCase = MockChangePasswordUseCase();
    viewModel = ChangePasswordViewModel(mockUseCase);
  });

  tearDown(() {
    viewModel.close();
  });

  test('initial state is correct', () {
    expect(viewModel.state, const ChangePasswordState());
  });

  group('Visibility toggle events', () {
    blocTest<ChangePasswordViewModel, ChangePasswordState>(
      'emits isOldPasswordVisible=true when ToggleOldPasswordVisibility is added',
      build: () => viewModel,
      act: (cubit) => cubit.doEvent(ToggleOldPasswordVisibility()),
      expect: () => [
        const ChangePasswordState(isOldPasswordVisible: true),
      ],
    );

    blocTest<ChangePasswordViewModel, ChangePasswordState>(
      'emits isNewPasswordVisible=true when ToggleNewPasswordVisibility is added',
      build: () => viewModel,
      act: (cubit) => cubit.doEvent(ToggleNewPasswordVisibility()),
      expect: () => [
        const ChangePasswordState(isNewPasswordVisible: true),
      ],
    );

    blocTest<ChangePasswordViewModel, ChangePasswordState>(
      'emits isConfirmPasswordVisible=true when ToggleConfirmPasswordVisibility is added',
      build: () => viewModel,
      act: (cubit) => cubit.doEvent(ToggleConfirmPasswordVisibility()),
      expect: () => [
        const ChangePasswordState(isConfirmPasswordVisible: true),
      ],
    );

    blocTest<ChangePasswordViewModel, ChangePasswordState>(
      'toggles back to false on second dispatch',
      build: () => viewModel,
      act: (cubit) {
        cubit.doEvent(ToggleOldPasswordVisibility());
        cubit.doEvent(ToggleOldPasswordVisibility());
      },
      expect: () => [
        const ChangePasswordState(isOldPasswordVisible: true),
        const ChangePasswordState(isOldPasswordVisible: false),
      ],
    );
  });

  group('UpdatePasswordEvent', () {
    const oldPassword = 'oldPass123';
    const newPassword = 'newPass456';
    const successMessage = 'Password changed successfully';

    blocTest<ChangePasswordViewModel, ChangePasswordState>(
      'emits [loading, success] when use case returns Success',
      build: () {
        when(() => mockUseCase.call(oldPassword, newPassword)).thenAnswer(
          (_) async => const Success<ChangePasswordResponseEntity>(
            data: ChangePasswordResponseEntity(message: successMessage),
          ),
        );
        return viewModel;
      },
      act: (cubit) => cubit.doEvent(
        UpdatePasswordEvent(password: oldPassword, newPassword: newPassword),
      ),
      expect: () => [
        const ChangePasswordState(isLoading: true, isDone: false),
        const ChangePasswordState(
          isLoading: false,
          isDone: true,
          message: successMessage,
        ),
      ],
      verify: (_) {
        verify(() => mockUseCase.call(oldPassword, newPassword)).called(1);
      },
    );

    blocTest<ChangePasswordViewModel, ChangePasswordState>(
      'emits [loading, error-with-message] when use case returns Error',
      build: () {
        when(() => mockUseCase.call(oldPassword, newPassword)).thenAnswer(
          (_) async => Error<ChangePasswordResponseEntity>(
            exception: Exception('Something went wrong'),
          ),
        );
        return viewModel;
      },
      act: (cubit) => cubit.doEvent(
        UpdatePasswordEvent(password: oldPassword, newPassword: newPassword),
      ),
      expect: () => [
        const ChangePasswordState(isLoading: true, isDone: false),
        isA<ChangePasswordState>()
            .having((s) => s.isLoading, 'isLoading', false)
            .having((s) => s.isDone, 'isDone', true)
            .having(
              (s) => s.message,
              'message',
              contains('Something went wrong'),
            ),
      ],
      verify: (_) {
        verify(() => mockUseCase.call(oldPassword, newPassword)).called(1);
      },
    );
  });
}