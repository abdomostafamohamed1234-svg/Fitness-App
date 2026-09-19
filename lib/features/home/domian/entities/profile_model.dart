class ProfileModel {
  final String firstName;
  final String lastName;
  final String photo;

  ProfileModel({
    required this.firstName,
    required this.lastName,
    required this.photo,
  });

  String get fullName => '$firstName $lastName';
}