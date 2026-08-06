import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class TokenLocalDataSource {
  TokenLocalDataSource(this._secureStorage);

  final FlutterSecureStorage _secureStorage;

  static const String _tokenKey = 'auth_token';

  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: _tokenKey, value: token);
  }

  Future<String?> getToken() async {
    return _secureStorage.read(key: _tokenKey);
  }

  Future<void> clearToken() async {
    await _secureStorage.delete(key: _tokenKey);
  }
}