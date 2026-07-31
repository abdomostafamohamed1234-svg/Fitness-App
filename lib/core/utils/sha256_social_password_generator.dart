import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flowery/core/utils/social_password_generator.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: SocialPasswordGenerator)
class Sha256SocialPasswordGenerator implements SocialPasswordGenerator {
  @override
  String generate(String uid) {
    return sha256.convert(utf8.encode(uid)).toString();
  }
}
