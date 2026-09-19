import 'package:flowery/features/workouts/domain/entities/muscle_group_by_id_response_entity.dart';
import 'package:json_annotation/json_annotation.dart';

import 'muscle_group_model.dart';
import 'muscle_model.dart';

part 'muscle_group_by_id_response.g.dart';

@JsonSerializable()
class MuscleGroupByIdResponse extends MuscleGroupByIdResponseEntity {
  @override
  @JsonKey(name: "message")
  final String? message;

  @override
  @JsonKey(name: "muscleGroup")
  final MuscleGroupModel? muscleGroup;

  @override
  @JsonKey(name: "muscles")
  final List<MuscleModel>? muscles;

  MuscleGroupByIdResponse({
    this.message,
    this.muscleGroup,
    this.muscles,
  }) : super(message: message, muscleGroup: muscleGroup, muscles: muscles);

  factory MuscleGroupByIdResponse.fromJson(Map<String, dynamic> json) {
    return _$MuscleGroupByIdResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MuscleGroupByIdResponseToJson(this);
  }
}
