// NOTE: adjust this import path if RegisterUsecase lives elsewhere in your project.
import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/register/domain/entities/register_entity.dart';
import 'package:flowery/features/register/domain/repositories/register_repository.dart';
import 'package:flowery/features/register/domain/use_cases/register_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'register_usecase_test.mocks.dart';

@GenerateMocks([RegisterRepository])
void main() {
  late RegisterUsecase useCase;
  late MockRegisterRepository mockRepository;
  setUpAll(() {
    provideDummy<Result<RegisterEntity>>(
      const Success<RegisterEntity>(data: null),
    );
  });
  setUp(() {
    mockRepository = MockRegisterRepository();
    useCase = RegisterUsecase(mockRepository);
  });

  final tBody = <String, dynamic>{
    'firstName': 'Ahmed',
    'email': 'ahmed@test.com',
    'password': '123456',
  };

  final tRegisterEntity = const RegisterEntity(message: 'Success', error: null);

  group('RegisterUsecase.invoke', () {
    test(
      'should call RegisterRepository.register with the given body and '
      'return Success when the repository succeeds',
      () async {
        // arrange
        when(mockRepository.register(any)).thenAnswer(
          (_) async => Success<RegisterEntity>(data: tRegisterEntity),
        );

        // act
        final result = await useCase.invoke(tBody);

        // assert
        expect(result, isA<Success<RegisterEntity>>());
        expect((result as Success<RegisterEntity>).data?.message, 'Success');
        verify(mockRepository.register(tBody)).called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );

    test(
      'should return Error with the same exception when the repository fails',
      () async {
        // arrange
        final exception = Exception('Something went wrong');
        when(mockRepository.register(any)).thenAnswer(
          (_) async => Error<RegisterEntity>(exception: exception),
        );

        // act
        final result = await useCase.invoke(tBody);

        // assert
        expect(result, isA<Error<RegisterEntity>>());
        expect((result as Error<RegisterEntity>).exception, exception);
        verify(mockRepository.register(tBody)).called(1);
      },
    );

    test(
      'should not swallow or transform the body passed to the repository',
      () async {
        // arrange
        when(mockRepository.register(any)).thenAnswer(
          (_) async => Success<RegisterEntity>(data: tRegisterEntity),
        );

        // act
        await useCase.invoke(tBody);

        // assert
        final captured =
            verify(mockRepository.register(captureAny)).captured.single
                as Map<String, dynamic>;
        expect(captured, equals(tBody));
      },
    );
  });
}