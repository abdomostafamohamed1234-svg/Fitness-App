import 'package:flowery/config/exception_handlers/app_exception.dart';
import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/login/data/data_source/remote_data_source/login_remote_data_source_contract.dart';
import 'package:flowery/features/login/data/models/request/login_request_model.dart';
import 'package:flowery/features/login/data/models/response/login_response_model.dart';
import 'package:flowery/features/login/data/models/response/user_response_model.dart';
import 'package:flowery/features/login/data/repo/login_repo_impl.dart';
import 'package:flowery/features/login/domain/entity/login_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockLoginRemoteDataSource extends Mock
    implements LoginRemoteDataSourceContract {}

void main() {
  late _MockLoginRemoteDataSource remoteDataSource;
  late LoginRepoImpl repo;

  const request = LoginRequestModel(
    email: 'test@example.com',
    password: 'password123',
  );

  setUpAll(() {
    registerFallbackValue(request);
  });

  setUp(() {
    remoteDataSource = _MockLoginRemoteDataSource();
    repo = LoginRepoImpl(remoteDataSource);
  });

  test('maps a successful response to a LoginEntity', () async {
    final response = LoginResponse(
      message: 'ok',
      token: 'token123',
      user: UserResponseModel(
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
    when(() => remoteDataSource.login(request))
        .thenAnswer((_) async => Success(data: response));

    final result = await repo.login(request);

    expect(result, isA<Success<LoginEntity>>());
    final entity = (result as Success<LoginEntity>).data!;
    expect(entity.message, 'ok');
    expect(entity.token, 'token123');
    expect(entity.user.firstName, 'John');
  });

  test('propagates the exception when the data source returns an Error', () async {
    const exception = AppException('failed');
    when(() => remoteDataSource.login(request))
        .thenAnswer((_) async => const Error(exception: exception));

    final result = await repo.login(request);

    expect(result, isA<Error<LoginEntity>>());
    expect((result as Error<LoginEntity>).exception, exception);
  });
}
