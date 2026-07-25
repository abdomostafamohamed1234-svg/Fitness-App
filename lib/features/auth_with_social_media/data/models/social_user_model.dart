class SocialUserModel {
  final String uid;
  final String email;
  final String firstName;
  final String lastName;
  final String? photoUrl;
  final String provider;
  final String providerToken;

  const SocialUserModel({
    required this.uid,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.photoUrl,
    required this.provider,
    required this.providerToken,
  });
}
