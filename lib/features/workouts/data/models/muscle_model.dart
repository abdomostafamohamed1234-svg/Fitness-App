import 'package:flowery/features/workouts/domain/entities/muscle_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'muscle_model.g.dart';

@JsonSerializable()
class MuscleModel extends MuscleEntity {
  @override
  @JsonKey(name: "_id")
  final String? id;

  @override
  @JsonKey(name: "name")
  final String? name;

  @override
  @JsonKey(name: "image")
  final String? image;

  MuscleModel({
    this.id,
    this.name,
    this.image,
  }) : super(id: id, name: name, image: image);

  factory MuscleModel.fromJson(Map<String, dynamic> json) {
    return _$MuscleModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MuscleModelToJson(this);
  }
}
