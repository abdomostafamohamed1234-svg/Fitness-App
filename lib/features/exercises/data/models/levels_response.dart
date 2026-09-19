import 'package:json_annotation/json_annotation.dart';

part 'levels_response.g.dart';

@JsonSerializable()
class LevelsResponse {
    @JsonKey(name: "message")
    String? message;
    @JsonKey(name: "totalLevels")
    int? totalLevels;
    @JsonKey(name: "difficulty_levels")
    List<DifficultyLevel>? difficultyLevels;

    LevelsResponse({
        this.message,
        this.totalLevels,
        this.difficultyLevels,
    });

    factory LevelsResponse.fromJson(Map<String, dynamic> json) => _$LevelsResponseFromJson(json);

    Map<String, dynamic> toJson() => _$LevelsResponseToJson(this);
}

@JsonSerializable()
class DifficultyLevel {
    @JsonKey(name: "id")
    String? id;
    @JsonKey(name: "name")
    String? name;

    DifficultyLevel({
        this.id,
        this.name,
    });

    factory DifficultyLevel.fromJson(Map<String, dynamic> json) => _$DifficultyLevelFromJson(json);

    Map<String, dynamic> toJson() => _$DifficultyLevelToJson(this);
}
