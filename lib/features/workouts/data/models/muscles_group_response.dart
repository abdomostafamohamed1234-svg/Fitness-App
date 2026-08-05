import 'package:json_annotation/json_annotation.dart';

import 'muscle_group_model.dart';

part 'muscles_group_response.g.dart';

@JsonSerializable()
class MusclesGroupResponse {
  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "musclesGroup")
  final List<MuscleGroupModel>? musclesGroup;

  MusclesGroupResponse({
    this.message,
    this.musclesGroup,
  });

  factory MusclesGroupResponse.fromJson(Map<String, dynamic> json) {
    return _$MusclesGroupResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MusclesGroupResponseToJson(this);
  }
}
