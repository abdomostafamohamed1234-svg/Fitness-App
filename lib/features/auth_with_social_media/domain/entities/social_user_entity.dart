import 'package:equatable/equatable.dart';

class SocialUserEntity extends Equatable {
  final String uid;
  final String email;
  final String firstName;
  final String lastName;
  final String? photoUrl;
  final String provider; 
  final String providerToken;

  const SocialUserEntity({
    required this.uid,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.photoUrl,
    required this.provider,
    required this.providerToken,
  });

  @override
  List<Object?> get props => [
    uid,
    email,
    firstName,
    lastName,
    photoUrl,
    provider,
    providerToken,
  ];
}
