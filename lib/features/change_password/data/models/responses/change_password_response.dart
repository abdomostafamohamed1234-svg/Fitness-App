// To parse this JSON data, do
//
//     final changePasswordResponse = changePasswordResponseFromJson(jsonString);

import 'package:flowery/features/change_password/domain/entities/change_password_response_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'change_password_response.g.dart';

ChangePasswordResponse changePasswordResponseFromJson(String str) =>
    ChangePasswordResponse.fromJson(json.decode(str));

String changePasswordResponseToJson(ChangePasswordResponse data) =>
    json.encode(data.toJson());

@JsonSerializable()
class ChangePasswordResponse {
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'token')
  String? token;
  @JsonKey(name: 'error')
  String? error;

  ChangePasswordResponse({this.message, this.token, this.error});

  factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChangePasswordResponseToJson(this);

  ChangePasswordResponseEntity toEntity() =>
      ChangePasswordResponseEntity(message: message ?? "");
}
