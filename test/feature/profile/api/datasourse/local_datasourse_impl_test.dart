import 'package:flowery/feature/profile/api/datasourse/local_datasourse_impl.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([FlutterSecureStorage])
import 'local_datasourse_impl_test.mocks.dart';

void main() {
  late MockFlutterSecureStorage mockSecureStorage;
  late TokenLocalDataSource tokenLocalDataSource;

  const tokenKey = 'auth_token';
  const fakeToken = 'fake_jwt_token_12345';

  setUp(() {
    mockSecureStorage = MockFlutterSecureStorage();
    tokenLocalDataSource = TokenLocalDataSource(mockSecureStorage);
  });

  group('saveToken', () {
    test('لازم يستدعي write بالـ key والـ value الصح', () async {
      when(mockSecureStorage.write(key: tokenKey, value: fakeToken))
          .thenAnswer((_) async => Future.value());

      await tokenLocalDataSource.saveToken(fakeToken);

      verify(mockSecureStorage.write(key: tokenKey, value: fakeToken))
          .called(1);
    });
  });

  group('getToken', () {
    test('لازم يرجع التوكين لما يكون موجود', () async {
      when(mockSecureStorage.read(key: tokenKey))
          .thenAnswer((_) async => fakeToken);

      final result = await tokenLocalDataSource.getToken();

      expect(result, fakeToken);
      verify(mockSecureStorage.read(key: tokenKey)).called(1);
    });

    test('لازم يرجع null لما التوكين مش موجود', () async {
      when(mockSecureStorage.read(key: tokenKey))
          .thenAnswer((_) async => null);

      final result = await tokenLocalDataSource.getToken();

      expect(result, isNull);
      verify(mockSecureStorage.read(key: tokenKey)).called(1);
    });
  });

  group('clearToken', () {
    test('لازم يستدعي delete بالـ key الصح', () async {
      when(mockSecureStorage.delete(key: tokenKey))
          .thenAnswer((_) async => Future.value());

      await tokenLocalDataSource.clearToken();

      verify(mockSecureStorage.delete(key: tokenKey)).called(1);
    });
  });
}