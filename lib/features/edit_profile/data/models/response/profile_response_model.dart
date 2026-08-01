import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entity/profile_entity.dart';
import 'user_response_model.dart';

part 'profile_response_model.g.dart';

@JsonSerializable()
class ProfileResponseModel {
  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "user")
  UserResponseModel? user;

  ProfileResponseModel({
    this.message,
    this.user,
  });

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileResponseModelToJson(this);

  ProfileEntity toDomain() {
    return ProfileEntity(
      message: message ?? '',
      user: user?.toDomain(),
    );
  }
}
