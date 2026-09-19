import 'package:json_annotation/json_annotation.dart';

part 'recommendation_to_day_response_dto.g.dart';

@JsonSerializable()
class RecommendationToDayResponseDto {
  final String message;
  final int totalMuscles;
  final List<Muscle> muscles;

  RecommendationToDayResponseDto({
    required this.message,
    required this.totalMuscles,
    required this.muscles,
  });

  factory RecommendationToDayResponseDto.fromJson(Map<String, dynamic> json) =>
      _$RecommendationToDayResponseDtoFromJson(json);

  Map<String, dynamic> toJson() =>
      _$RecommendationToDayResponseDtoToJson(this);
}

@JsonSerializable()
class Muscle {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String? image;

  Muscle({
    required this.id,
    required this.name,
    this.image,
  });

  factory Muscle.fromJson(Map<String, dynamic> json) =>
      _$MuscleFromJson(json);

  Map<String, dynamic> toJson() => _$MuscleToJson(this);
}