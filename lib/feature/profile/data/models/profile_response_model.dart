import 'package:flowery/feature/profile/domain/entities/profile_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_response_model.g.dart';

/// شكل الريسبونس زي ما هو راجع من:
/// GET https://fitness.elevateegy.com/api/v1/auth/profile-data
/// {
///   "message": "success",
///   "user": { ... }
/// }
@JsonSerializable()
class ProfileResponseModel {
  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'user')
  final ProfileUserModel user;

  const ProfileResponseModel({required this.message, required this.user});

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileResponseModelToJson(this);

  /// Maps the data model to the domain entity used across the app.
  ProfileEntity toEntity() => user.toEntity();
}

@JsonSerializable()
class ProfileUserModel {
  @JsonKey(name: '_id')
  final String id;

  @JsonKey(name: 'firstName')
  final String firstName;

  @JsonKey(name: 'lastName')
  final String lastName;

  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'gender')
  final String? gender;

  @JsonKey(name: 'age')
  final int? age;

  @JsonKey(name: 'weight')
  final num? weight;

  @JsonKey(name: 'height')
  final num? height;

  @JsonKey(name: 'activityLevel')
  final String? activityLevel;

  @JsonKey(name: 'goal')
  final String? goal;

  @JsonKey(name: 'photo')
  final String? photo;

  @JsonKey(name: 'createdAt')
  final String? createdAt;

  @JsonKey(name: 'passwordChangedAt')
  final String? passwordChangedAt;

  const ProfileUserModel({
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
    this.photo,
    this.createdAt,
    this.passwordChangedAt,
  });

  factory ProfileUserModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileUserModelToJson(this);

  ProfileEntity toEntity() {
    return ProfileEntity(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      gender: gender,
      age: age,
      weight: weight,
      height: height,
      activityLevel: activityLevel,
      goal: goal,
      profileImage: photo,
    );
  }
}