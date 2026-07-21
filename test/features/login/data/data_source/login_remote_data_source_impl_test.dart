import 'package:dio/dio.dart';
import 'package:flowery/config/di/di_config.dart';
import 'package:flowery/config/helpers/shared_preferences/shared_preferences_helper.dart';
import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/login/api/login_api_client.dart';
import 'package:flowery/features/login/data/data_source/remote_data_source/login_remote_data_source_impl.dart';
import 'package:flowery/features/login/data/models/request/login_request_model.dart';
import 'package:flowery/features/login/data/models/response/login_response_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockLoginApiClient extends Mock implements LoginApiClient {}

class _MockSharedPreferencesHelper extends Mock
    implements SharedPreferencesHelper {}

void main() {
  late _MockLoginApiClient apiClient;
  late LoginRemoteDataSourceImpl dataSource;

  const request = LoginRequestModel(
    email: 'test@example.com',
    password: 'password123',
  );

  setUpAll(() {
    registerFallbackValue(request);
  });

  setUp(() {
    apiClient = _MockLoginApiClient();
    dataSource = LoginRemoteDataSourceImpl(apiClient);

    final fakePrefsHelper = _MockSharedPreferencesHelper();
    when(() => fakePrefsHelper.getString('locale')).thenReturn('en');
    getIt.registerSingleton<SharedPreferencesHelper>(fakePrefsHelper);
  });

  tearDown(() {
    getIt.reset();
  });

  test('returns Success with the response when the api call succeeds', () async {
    final response = LoginResponse(message: 'ok', token: 'token123');
    when(() => apiClient.login(request)).thenAnswer((_) async => response);

    final result = await dataSource.login(request);

    expect(result, isA<Success<LoginResponse>>());
    expect((result as Success<LoginResponse>).data, response);
  });

  test('returns Error with a handled AppException when a DioException is thrown', () async {
    final dioException = DioException(
      requestOptions: RequestOptions(path: '/login'),
      type: DioExceptionType.connectionTimeout,
    );
    when(() => apiClient.login(request)).thenThrow(dioException);

    final result = await dataSource.login(request);

    expect(result, isA<Error<LoginResponse>>());
    expect((result as Error<LoginResponse>).exception, isNotNull);
  });

  test('returns Error with an AppException when a generic Exception is thrown', () async {
    when(() => apiClient.login(request)).thenThrow(Exception('boom'));

    final result = await dataSource.login(request);

    expect(result, isA<Error<LoginResponse>>());
    expect((result as Error<LoginResponse>).exception.toString(), contains('boom'));
  });
}
