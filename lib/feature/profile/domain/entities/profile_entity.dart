class ProfileEntity {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String? gender;
  final int? age;
  final num? weight;
  final num? height;
  final String? activityLevel;
  final String? goal;
  final String? profileImage;

  const ProfileEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.gender,
    this.age,
    this.weight,
    this.height,
    this.activityLevel,
    this.goal,
    this.profileImage,
  });

  String get name => '$firstName $lastName'.trim();
}