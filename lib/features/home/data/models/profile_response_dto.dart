import 'package:json_annotation/json_annotation.dart';

part 'profile_response_dto.g.dart';

@JsonSerializable()
class ProfileResponseDto {
  final String message;
  final UserDto user;

  ProfileResponseDto({
    required this.message,
    required this.user,
  });

  factory ProfileResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileResponseDtoToJson(this);
}

@JsonSerializable()
class UserDto {
  @JsonKey(name: '_id')
  final String id;
  final String firstName;
  final String lastName;
  final String photo;

  UserDto({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.photo,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}