// /// Domain entity for the user profile.
// ///
// /// NOTE: الفيلدز دي مبنية على شكل شاشة الـ Profile اللي بعتيها (الاسم + الصورة).
// /// الـ API response الحقيقي مبعتش لسه (اللي اتبعت كانت صورة الديزاين مش صورة الـ JSON)،
// /// فلو الـ response بتاعك فيه فيلدز تانية (email, phone, gender, ...) قوليلي
// /// وهعدل الموديل + الـ ProfileResponseModel على طول.
// class ProfileEntity {
//   final String id;
//   final String name;
//   final String? email;
//   final String? phone;
//   final String? profileImage;

//   const ProfileEntity({
//     required this.id,
//     required this.name,
//     this.email,
//     this.phone,
//     this.profileImage,
//   });
// }



/// Domain entity for the user profile, matching the fields actually
/// returned by GET /auth/profile-data.
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

  /// خليتها getter بدل ما تبقى فيلد، عشان شاشة الـ Profile بتستخدم
  /// `data.name` جاهزة زي ما هي من غير ما نلمس profile_screen.dart.
  String get name => '$firstName $lastName'.trim();
}