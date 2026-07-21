import 'package:bloc_test/bloc_test.dart';
import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/core/base/base_state.dart';
import 'package:flowery/features/login/data/models/request/login_request_model.dart';
import 'package:flowery/features/login/domain/entity/login_entity.dart';
import 'package:flowery/features/login/domain/entity/user_entity.dart';
import 'package:flowery/features/login/domain/use_case/login_use_case.dart';
import 'package:flowery/features/login/presentation/view_model/cubit.dart';
import 'package:flowery/features/login/presentation/view_model/event.dart';
import 'package:flowery/features/login/presentation/view_model/state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockLoginUseCase extends Mock implements LoginUseCase {}

void main() {
  late _MockLoginUseCase useCase;

  const request = LoginRequestModel(
    email: 'test@example.com',
    password: 'password123',
  );

  final entity = LoginEntity(
    message: 'Login Successfully',
    token: 'token123',
    user: UserEntity(
      id: '1',
      firstName: 'John',
      lastName: 'Doe',
      email: 'test@example.com',
      gender: 'male',
      age: 25,
      weight: 70,
      height: 175,
      activityLevel: 'active',
      goal: 'lose weight',
      photo: '',
      createdAt: DateTime(2024, 1, 1),
    ),
  );

  setUpAll(() {
    registerFallbackValue(request);
  });

  setUp(() {
    useCase = _MockLoginUseCase();
  });

  TypeMatcher<LoginStates> stateMatcher(StateType type) =>
      isA<LoginStates>().having((s) => s.loginState.state, 'state', type);

  blocTest<LoginCubit, LoginStates>(
    'emits [loading, success] when login succeeds',
    build: () {
      when(() => useCase(any())).thenAnswer((_) async => Success(data: entity));
      return LoginCubit(useCase);
    },
    act: (cubit) => cubit.doEvent(
      LoginEvent(email: request.email, password: request.password),
    ),
    expect: () => [
      stateMatcher(StateType.loading),
      stateMatcher(StateType.success)
          .having((s) => s.loginState.data, 'data', entity),
    ],
  );

  blocTest<LoginCubit, LoginStates>(
    'emits [loading, error] when login fails',
    build: () {
      when(() => useCase(any())).thenAnswer(
        (_) async => const Error(exception: FormatException('invalid credentials')),
      );
      return LoginCubit(useCase);
    },
    act: (cubit) => cubit.doEvent(
      LoginEvent(email: request.email, password: request.password),
    ),
    expect: () => [
      stateMatcher(StateType.loading),
      stateMatcher(StateType.error),
    ],
  );
}
