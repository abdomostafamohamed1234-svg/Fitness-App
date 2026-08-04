import 'dart:convert';

import 'package:flowery/features/change_password/domain/entities/change_password_entity.dart';
import 'package:json_annotation/json_annotation.dart';



part 'change_password_request.g.dart';

ChangePasswordRequest changePasswordRequestFromJson(String str) =>
    ChangePasswordRequest.fromJson(json.decode(str));

String changePasswordRequestToJson(ChangePasswordRequest data) =>
    json.encode(data.toJson());

@JsonSerializable()
class ChangePasswordRequest extends ChangePasswordEntity {
  
  @JsonKey(name: "password")
 
  final String password;


  @JsonKey(name: "newPassword")

  final String newPassword;

  const ChangePasswordRequest({
    required this.password,
    required this.newPassword,
  }) : super(
          password: password,
          newPassword: newPassword,
        );

  factory ChangePasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ChangePasswordRequestToJson(this);
}