import 'package:json_annotation/json_annotation.dart';

part 'level_model_response.g.dart';

@JsonSerializable()
class LevelModel {
  @JsonKey(name: '_id')
  final String id;
  final String name;

  const LevelModel({required this.id, required this.name});

  factory LevelModel.fromJson(Map<String, dynamic> json) =>
      _$LevelModelFromJson(json);

  Map<String, dynamic> toJson() => _$LevelModelToJson(this);
}

@JsonSerializable()
class LevelsResponse {
  final String message;
  final List<LevelModel> levels;

  const LevelsResponse({required this.message, required this.levels});

  factory LevelsResponse.fromJson(Map<String, dynamic> json) =>
      _$LevelsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LevelsResponseToJson(this);
}