import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/register/api/api_client/register_api_client.dart';
import 'package:flowery/features/register/api/datasources/register_local_data_source_impl.dart';
import 'package:flowery/features/register/data/models/register_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'register_local_data_source_impl_test.mocks.dart';

@GenerateMocks([RegisterApiClient])
void main() {
  late RegisterLocalDataSourceImpl dataSource;
  late MockRegisterApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockRegisterApiClient();
    dataSource = RegisterLocalDataSourceImpl(mockApiClient);
  });

  final tBody = <String, dynamic>{'email': 'ahmed@test.com'};

  group('RegisterLocalDataSourceImpl.register', () {
    test(
      'should return Success<RegisterDto> when the api client succeeds',
      () async {
        // arrange
        final tDto = RegisterDto(message: 'Registered', token: 'abc123');
        when(mockApiClient.register(any)).thenAnswer((_) async => tDto);

        // act
        final result = await dataSource.register(tBody);

        // assert
        expect(result, isA<Success<RegisterDto>>());
        expect((result as Success<RegisterDto>).data?.token, 'abc123');
        verify(mockApiClient.register(tBody)).called(1);
      },
    );

    test(
      'should return Error<RegisterDto> with the thrown exception '
      'when the api client throws an Exception',
      () async {
        // arrange
        final exception = Exception('server error');
        when(mockApiClient.register(any)).thenThrow(exception);

        // act
        final result = await dataSource.register(tBody);

        // assert
        expect(result, isA<Error<RegisterDto>>());
        expect((result as Error<RegisterDto>).exception, exception);
      },
    );

    test(
      'should wrap non-Exception errors into an Exception '
      'inside Error<RegisterDto>',
      () async {
        // arrange
        when(mockApiClient.register(any)).thenThrow('raw string error');

        // act
        final result = await dataSource.register(tBody);

        // assert
        expect(result, isA<Error<RegisterDto>>());
        expect(
          (result as Error<RegisterDto>).exception.toString(),
          contains('raw string error'),
        );
      },
    );

    test('should forward the exact body to the api client', () async {
      // arrange
      final tDto = RegisterDto(message: 'ok');
      when(mockApiClient.register(any)).thenAnswer((_) async => tDto);

      // act
      await dataSource.register(tBody);

      // assert
      final captured =
          verify(mockApiClient.register(captureAny)).captured.single
              as Map<String, dynamic>;
      expect(captured, equals(tBody));
    });
  });
}