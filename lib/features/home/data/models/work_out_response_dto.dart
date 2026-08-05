import 'package:json_annotation/json_annotation.dart';

part 'work_out_response_dto.g.dart';

@JsonSerializable()
class WorkOutResponseDto {
  final String message;
  final List<MuscleGroup> musclesGroup;

  WorkOutResponseDto({
    required this.message,
    required this.musclesGroup,
  });

  factory WorkOutResponseDto.fromJson(Map<String, dynamic> json) =>
      _$WorkOutResponseDtoFromJson(json);

  Map<String, dynamic> toJson() =>
      _$WorkOutResponseDtoToJson(this);
}

@JsonSerializable()
class MuscleGroup {
  @JsonKey(name: '_id')
  final String id;
  final String name;

  MuscleGroup({
    required this.id,
    required this.name,
  });

  factory MuscleGroup.fromJson(Map<String, dynamic> json) =>
      _$MuscleGroupFromJson(json);

  Map<String, dynamic> toJson() =>
      _$MuscleGroupToJson(this);
}