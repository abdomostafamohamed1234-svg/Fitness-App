import 'package:json_annotation/json_annotation.dart';

part 'edit_profile_request_model.g.dart';

@JsonSerializable(includeIfNull: false)
class EditProfileRequestModel {
  @JsonKey(name: 'firstName')
  final String? firstName;

  @JsonKey(name: 'lastName')
  final String? lastName;

  @JsonKey(name: 'email')
  final String? email;

  @JsonKey(name: 'gender')
  final String? gender;

  @JsonKey(name: 'age')
  final int? age;

  @JsonKey(name: 'weight')
  final int? weight;

  @JsonKey(name: 'height')
  final int? height;

  @JsonKey(name: 'activityLevel')
  final String? activityLevel;

  @JsonKey(name: 'goal')
  final String? goal;

  const EditProfileRequestModel({
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.age,
    this.weight,
    this.height,
    this.activityLevel,
    this.goal,
  });

  factory EditProfileRequestModel.fromJson(Map<String, dynamic> json) =>
      _$EditProfileRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$EditProfileRequestModelToJson(this);
}
