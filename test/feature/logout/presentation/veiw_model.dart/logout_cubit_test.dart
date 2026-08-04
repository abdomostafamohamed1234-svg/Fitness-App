import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/core/base/base_state.dart';
import 'package:flowery/feature/logout/domian/usecase/logout_usecase.dart';
import 'package:flowery/feature/logout/presentation/veiw_model.dart/logout_cubit.dart';
import 'package:flowery/feature/logout/presentation/veiw_model.dart/logout_event.dart';
import 'package:flowery/feature/logout/presentation/veiw_model.dart/logout_state.dart';

@GenerateMocks([LogoutUseCase])
import 'logout_cubit_test.mocks.dart';

void main() {
  late MockLogoutUseCase mockUseCase;
  late LogoutCubit logoutCubit;

  setUp(() {
    provideDummy<Result<void>>(const Success(data: null));
    mockUseCase = MockLogoutUseCase();
    logoutCubit = LogoutCubit(mockUseCase);
  });

  tearDown(() {
    logoutCubit.close();
  });

  test('الحالة الابتدائية لازم تكون logoutState = BaseState.initial()', () {
    expect(logoutCubit.state.logoutState, const BaseState<void>.initial());
  });

  group('DoLogoutEvent', () {
    blocTest<LogoutCubit, LogoutStates>(
      'لازم يطلع [loading, success] لما الـ usecase يرجع Success',
      build: () {
        when(mockUseCase.call()).thenAnswer((_) async => const Success(data: null));
        return logoutCubit;
      },
      act: (cubit) => cubit.doAction(const DoLogoutEvent()),
      expect: () => [
        isA<LogoutStates>().having(
          (s) => s.logoutState,
          'logoutState',
          const BaseState<void>.loading(),
        ),
        isA<LogoutStates>().having(
          (s) => s.logoutState,
          'logoutState',
          const BaseState<void>.success(null),
        ),
      ],
      verify: (_) {
        verify(mockUseCase.call()).called(1);
      },
    );

    blocTest<LogoutCubit, LogoutStates>(
      'لازم يطلع [loading, error] لما الـ usecase يرجع Error',
      build: () {
        final exception = Exception('فشل تسجيل الخروج');
        when(mockUseCase.call())
            .thenAnswer((_) async => Error(exception: exception));
        return logoutCubit;
      },
      act: (cubit) => cubit.doAction(const DoLogoutEvent()),
      expect: () => [
        isA<LogoutStates>().having(
          (s) => s.logoutState.state,
          'logoutState.state',
          StateType.loading,
        ),
        isA<LogoutStates>().having(
          (s) => s.logoutState.state,
          'logoutState.state',
          StateType.error,
        ),
      ],
      verify: (_) {
        verify(mockUseCase.call()).called(1);
      },
    );

    blocTest<LogoutCubit, LogoutStates>(
      'مايعملش emit تاني بعد ما الـ cubit يتقفل (isClosed guard)',
      build: () {
        when(mockUseCase.call()).thenAnswer((_) async => const Success(data: null));
        return logoutCubit;
      },
      act: (cubit) async {
        await cubit.close();
        cubit.doAction(const DoLogoutEvent());
      },
      expect: () => [],
    );
  });
}