import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/core/base/base_state.dart';
import 'package:flowery/feature/profile/domain/entities/profile_entity.dart';
import 'package:flowery/feature/profile/domain/usecase/profile_usecase.dart';
import 'package:flowery/feature/profile/presentation/view_model/profile_cubit.dart';
import 'package:flowery/feature/profile/presentation/view_model/profile_event.dart';
import 'package:flowery/feature/profile/presentation/view_model/profile_state.dart';

@GenerateMocks([ProfileUseCase])
import 'profile_cubit_test.mocks.dart';

void main() {
  late MockProfileUseCase mockUseCase;
  late ProfileCubit profileCubit;

  // ⚠️ عدّلي الـ constructor ده على حسب فيلدز ProfileEntity الحقيقية عندك
  final fakeEntity = const ProfileEntity(id: '', firstName: '', lastName: '', email: '');

  setUp(() {
    provideDummy<Result<ProfileEntity>>(Success(data: fakeEntity));
    mockUseCase = MockProfileUseCase();
    profileCubit = ProfileCubit(mockUseCase);
  });

  tearDown(() {
    profileCubit.close();
  });

  test('الحالة الابتدائية لازم تكون profileState = BaseState.initial()', () {
    expect(profileCubit.state.profileState, const BaseState<ProfileEntity>.initial());
  });

  group('GetProfileDataEvent', () {
    blocTest<ProfileCubit, ProfileStates>(
      'لازم يطلع [loading, success] لما الـ usecase يرجع Success',
      build: () {
        when(mockUseCase.callProfileData())
            .thenAnswer((_) async => Success(data: fakeEntity));
        return profileCubit;
      },
      act: (cubit) => cubit.doAction(GetProfileDataEvent()),
      expect: () => [
        isA<ProfileStates>().having(
          (s) => s.profileState,
          'profileState',
          const BaseState<ProfileEntity>.loading(),
        ),
        isA<ProfileStates>().having(
          (s) => s.profileState,
          'profileState',
          BaseState<ProfileEntity>.success(fakeEntity),
        ),
      ],
      verify: (_) {
        verify(mockUseCase.callProfileData()).called(1);
      },
    );

    blocTest<ProfileCubit, ProfileStates>(
      'لازم يطلع [loading, error] لما الـ usecase يرجع Error',
      build: () {
        final exception = Exception('فشل تحميل البروفايل');
        when(mockUseCase.callProfileData())
            .thenAnswer((_) async => Error(exception: exception));
        return profileCubit;
      },
      act: (cubit) => cubit.doAction(GetProfileDataEvent()),
      expect: () => [
        isA<ProfileStates>().having(
          (s) => s.profileState.state,
          'profileState.state',
          StateType.loading,
        ),
        isA<ProfileStates>().having(
          (s) => s.profileState.state,
          'profileState.state',
          StateType.error,
        ),
      ],
      verify: (_) {
        verify(mockUseCase.callProfileData()).called(1);
      },
    );

    blocTest<ProfileCubit, ProfileStates>(
      'مايعملش emit تاني بعد ما الـ cubit يتقفل (isClosed guard)',
      build: () {
        when(mockUseCase.callProfileData())
            .thenAnswer((_) async => Success(data: fakeEntity));
        return profileCubit;
      },
      act: (cubit) async {
        await cubit.close();
        cubit.doAction(GetProfileDataEvent());
      },
      expect: () => [],
    );
  });
}