import 'package:flowery/features/workouts/domain/entities/muscle_group_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'muscle_group_model.g.dart';

@JsonSerializable()
class MuscleGroupModel extends MuscleGroupEntity {
  @override
  @JsonKey(name: "_id")
  final String? id;

  @override
  @JsonKey(name: "name")
  final String? name;

  MuscleGroupModel({
    this.id,
    this.name,
  }) : super(id: id, name: name);

  factory MuscleGroupModel.fromJson(Map<String, dynamic> json) {
    return _$MuscleGroupModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MuscleGroupModelToJson(this);
  }
}
