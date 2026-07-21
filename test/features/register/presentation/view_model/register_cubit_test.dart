import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/core/base/base_state.dart';
import 'package:flowery/features/register/domain/entities/register_model.dart';
import 'package:flowery/features/register/domain/use_cases/register_usecase.dart';
import 'package:flowery/features/register/presentation/view_model/cubit/register_cubit.dart';
import 'package:flowery/features/register/presentation/view_model/cubit/register_events.dart';
import 'package:flowery/features/register/presentation/view_model/cubit/register_temp_events.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'register_cubit_test.mocks.dart';

@GenerateMocks([RegisterUsecase])
void main() {
  late RegisterCubit cubit;
  late MockRegisterUsecase mockUsecase;

  final tRegisterModel = RegisterModel(massage: 'Success', error: null);

  setUpAll(() {
    // dummy لـ Result<RegisterModel> علشان Mockito عارف يبني الـ mock method
    provideDummy<Result<RegisterModel>>(
      const Success<RegisterModel>(data: null),
    );
  });

  setUp(() {
    mockUsecase = MockRegisterUsecase();
    cubit = RegisterCubit(mockUsecase);
  });

  tearDown(() async {
    await cubit.close();
  });

  group('_register (Register event)', () {
    test(
      'success: يبعت ShowLoading -> HideLoading -> ShowMassage -> NavigateToLogin',
      () async {
        when(mockUsecase.invoke(any)).thenAnswer(
          (_) async => Success<RegisterModel>(data: tRegisterModel),
        );

        final events = <RegisterTempEvents>[];
        final sub = cubit.cubitStream.listen(events.add);

        cubit.doIntent(Register());
        await Future.delayed(const Duration(milliseconds: 50));

        expect(events[0], isA<ShowLoadingTempEvent>());
        expect(events[1], isA<HideLoadingTempEvent>());
        expect(events[2], isA<ShowMassageTempEvent>());
        expect((events[2] as ShowMassageTempEvent).message, 'Success');

        // الـ NavigateToLoginTempEvent بيتبعت بعد Future.delayed لمدة ثانيتين
        await Future.delayed(const Duration(seconds: 3));
        expect(events.last, isA<NavigateToLoginTempEvent>());

        verify(mockUsecase.invoke(any)).called(1);
        await sub.cancel();
      },
      timeout: const Timeout(Duration(seconds: 10)),
    );

    test(
      'failure: يبعت ShowLoading -> HideLoading -> ShowMassage(exception)',
      () async {
        final exception = Exception('Network error');
        when(mockUsecase.invoke(any)).thenAnswer(
          (_) async => Error<RegisterModel>(exception: exception),
        );

        final events = <RegisterTempEvents>[];
        final sub = cubit.cubitStream.listen(events.add);

        cubit.doIntent(Register());
        await Future.delayed(const Duration(milliseconds: 50));

        expect(events[0], isA<ShowLoadingTempEvent>());
        expect(events[1], isA<HideLoadingTempEvent>());
        expect(events[2], isA<ShowMassageTempEvent>());
        expect(
          (events[2] as ShowMassageTempEvent).message,
          exception.toString(),
        );

        verify(mockUsecase.invoke(any)).called(1);
        await sub.cancel();
      },
    );
  });

  group('_nextStep (RegisterNextStep event)', () {
    test('If registerState is null, make it 0.', () {
      cubit.state.registerState = null;

      cubit.doIntent(RegisterNextStep());

      expect(cubit.state.registerState?.data, 0);
    });

    test('If there is value, add 1 to it.', () {
      cubit.state.registerState = const BaseState(data: 2);

      cubit.doIntent(RegisterNextStep());

      expect(cubit.state.registerState?.data, 3);
    });
  });

  group('_previousStep (RegisterPreviousStep event)', () {
    test('لو الخطوة الحالية 0، يبعت NavigateToLoginTempEvent', () async {
      cubit.state.registerState = const BaseState(data: 0);
      final events = <RegisterTempEvents>[];
      final sub = cubit.cubitStream.listen(events.add);

      cubit.doIntent(RegisterPreviousStep());
      await Future.delayed(Duration.zero);

      expect(events, [isA<NavigateToLoginTempEvent>()]);
      await sub.cancel();
    });

    test('If the step is greater than 0, it is deducted by 1.', () {
      cubit.state.registerState = const BaseState(data: 2);

      cubit.doIntent(RegisterPreviousStep());

      expect(cubit.state.registerState?.data, 1);
    });
  });

  group('_navigateToLogin (NavigateToLoginEvent)', () {
    test('يبعت NavigateToLoginTempEvent', () async {
      final events = <RegisterTempEvents>[];
      final sub = cubit.cubitStream.listen(events.add);

      cubit.doIntent(NavigateToLoginEvent());
      await Future.delayed(Duration.zero);

      expect(events, [isA<NavigateToLoginTempEvent>()]);
      await sub.cancel();
    });
  });

  group('_showMassage (ShowMassageEvent)', () {
    test('يبعت ShowMassageTempEvent بنفس الرسالة', () async {
      final events = <RegisterTempEvents>[];
      final sub = cubit.cubitStream.listen(events.add);

      cubit.doIntent(ShowMassageEvent('Hello'));
      await Future.delayed(Duration.zero);

      expect(events, [isA<ShowMassageTempEvent>()]);
      expect((events.single as ShowMassageTempEvent).message, 'Hello');
      await sub.cancel();
    });
  });

  group('_showLoading / _hideLoading', () {
    test('ShowLoadingEvent يبعت ShowLoadingTempEvent', () async {
      final events = <RegisterTempEvents>[];
      final sub = cubit.cubitStream.listen(events.add);

      cubit.doIntent(ShowLoadingEvent());
      await Future.delayed(Duration.zero);

      expect(events, [isA<ShowLoadingTempEvent>()]);
      await sub.cancel();
    });

    test('HideLoadingEvent يبعت HideLoadingTempEvent', () async {
      final events = <RegisterTempEvents>[];
      final sub = cubit.cubitStream.listen(events.add);

      cubit.doIntent(HideLoadingEvent());
      await Future.delayed(Duration.zero);

      expect(events, [isA<HideLoadingTempEvent>()]);
      await sub.cancel();
    });
  });
}