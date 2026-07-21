// NOTE: adjust this import path if RegisterUsecase lives elsewhere in your project.
import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/register/domain/entities/register_model.dart';
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
    provideDummy<Result<RegisterModel>>(
      const Success<RegisterModel>(data: null),
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

  final tRegisterModel = RegisterModel(massage: 'Success', error: null);

  group('RegisterUsecase.invoke', () {
    test(
      'should call RegisterRepository.register with the given body and '
      'return Success when the repository succeeds',
      () async {
        // arrange
        when(mockRepository.register(any)).thenAnswer(
          (_) async => Success<RegisterModel>(data: tRegisterModel),
        );

        // act
        final result = await useCase.invoke(tBody);

        // assert
        expect(result, isA<Success<RegisterModel>>());
        expect((result as Success<RegisterModel>).data?.massage, 'Success');
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
          (_) async => Error<RegisterModel>(exception: exception),
        );

        // act
        final result = await useCase.invoke(tBody);

        // assert
        expect(result, isA<Error<RegisterModel>>());
        expect((result as Error<RegisterModel>).exception, exception);
        verify(mockRepository.register(tBody)).called(1);
      },
    );

    test(
      'should not swallow or transform the body passed to the repository',
      () async {
        // arrange
        when(mockRepository.register(any)).thenAnswer(
          (_) async => Success<RegisterModel>(data: tRegisterModel),
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