


import 'package:json_annotation/json_annotation.dart';

part 'muscle_model_response.g.dart';

@JsonSerializable()
class MuscleModel {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String? image;

  const MuscleModel({required this.id, required this.name, this.image});

  factory MuscleModel.fromJson(Map<String, dynamic> json) =>
      _$MuscleModelFromJson(json);

  Map<String, dynamic> toJson() => _$MuscleModelToJson(this);
}

@JsonSerializable()
class MusclesResponse {
  final String message;
  final int totalMuscles;
  final List<MuscleModel> muscles;

  const MusclesResponse({
    required this.message,
    required this.totalMuscles,
    required this.muscles,
  });

  factory MusclesResponse.fromJson(Map<String, dynamic> json) =>
      _$MusclesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MusclesResponseToJson(this);
}