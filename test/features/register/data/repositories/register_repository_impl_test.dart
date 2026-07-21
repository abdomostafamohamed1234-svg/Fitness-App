// NOTE: adjust this import path if RegisterRepositoryImpl lives elsewhere in your project.
import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/register/data/datasources/register_local_data_source_contract.dart';
import 'package:flowery/features/register/data/models/register_dto.dart';
import 'package:flowery/features/register/data/repositories/register_repository_impl.dart';
import 'package:flowery/features/register/domain/entities/register_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'register_repository_impl_test.mocks.dart';

@GenerateMocks([RegisterLocalDataSourceContract])
void main() {
  late RegisterRepositoryImpl repository;
  late MockRegisterLocalDataSourceContract mockDataSource;
 setUpAll(() {
    provideDummy<Result<RegisterDto>>(
      const Success<RegisterDto>(data: null),
    );
  });
  setUp(() {
    mockDataSource = MockRegisterLocalDataSourceContract();
    repository = RegisterRepositoryImpl(mockDataSource);
  });

  final tBody = <String, dynamic>{'email': 'ahmed@test.com'};

  group('RegisterRepositoryImpl.register', () {
    test(
      'should return Success<RegisterModel> built from dto.toModel() '
      'when the data source succeeds',
      () async {
        // arrange
        final tDto = RegisterDto(message: 'Registered', error: null);
        when(mockDataSource.register(any)).thenAnswer(
          (_) async => Success<RegisterDto>(data: tDto),
        );

        // act
        final result = await repository.register(tBody);

        // assert
        expect(result, isA<Success<RegisterModel>>());
        expect(
          (result as Success<RegisterModel>).data?.massage,
          'Registered',
        );
        verify(mockDataSource.register(tBody)).called(1);
      },
    );

    test(
      'should return Success<RegisterModel> with null data '
      'when the data source succeeds with null data',
      () async {
        // arrange
        when(mockDataSource.register(any)).thenAnswer(
          (_) async => const Success<RegisterDto>(data: null),
        );

        // act
        final result = await repository.register(tBody);

        // assert
        expect(result, isA<Success<RegisterModel>>());
        expect((result as Success<RegisterModel>).data, isNull);
      },
    );

    test(
      'should return Error<RegisterModel> with the same exception '
      'when the data source fails',
      () async {
        // arrange
        final exception = Exception('network error');
        when(mockDataSource.register(any)).thenAnswer(
          (_) async => Error<RegisterDto>(exception: exception),
        );

        // act
        final result = await repository.register(tBody);

        // assert
        expect(result, isA<Error<RegisterModel>>());
        expect((result as Error<RegisterModel>).exception, exception);
        verify(mockDataSource.register(tBody)).called(1);
      },
    );

    test('should forward the exact body to the data source', () async {
      // arrange
      final tDto = RegisterDto(message: 'ok');
      when(mockDataSource.register(any)).thenAnswer(
        (_) async => Success<RegisterDto>(data: tDto),
      );

      // act
      await repository.register(tBody);

      // assert
      final captured =
          verify(mockDataSource.register(captureAny)).captured.single
              as Map<String, dynamic>;
      expect(captured, equals(tBody));
    });
  });
}