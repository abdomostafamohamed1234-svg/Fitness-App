import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

/// مسؤول عن تخزين/قراءة/مسح التوكين محليًا.
///
/// لو عندك بالفعل كلاس مشابه (مثلاً استخدمتيه وقت الـ login عشان تخزني التوكين
/// بعد الـ signin) استخدمي هو نفسه وامسحي الملف ده، عشان متعمليش تخزين مكرر.
/// لو مفيش، الكلاس ده جاهز يتستخدم دلوقتي من فيتشر الـ profile، وبعدين من
/// فيتشر الـ logout (هيقرا نفس التوكين المخزن هنا عشان يبعته في الـ header
/// أو الـ body وقت عمل الـ logout API).
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