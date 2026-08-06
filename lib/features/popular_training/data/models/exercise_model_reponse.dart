import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/exercise_entity.dart';

part 'exercise_model_reponse.g.dart';

@JsonSerializable()
class ExerciseModel extends ExerciseEntity {
  @JsonKey(name: '_id')
  final String idJson;

  @JsonKey(name: 'exercise')
  final String nameJson;

  @JsonKey(name: 'difficulty_level')
  final String difficultyLevelJson;

  @JsonKey(name: 'target_muscle_group')
  final String targetMuscleGroupJson;

  @JsonKey(name: 'prime_mover_muscle')
  final String primeMoverMuscleJson;

  @JsonKey(name: 'secondary_muscle')
  final String? secondaryMuscleJson;

  @JsonKey(name: 'tertiary_muscle')
  final String? tertiaryMuscleJson;

  @JsonKey(name: 'primary_equipment')
  final String? primaryEquipmentJson;

  @JsonKey(name: 'secondary_equipment')
  final String? secondaryEquipmentJson;

  final String? posture;

  @JsonKey(name: 'short_youtube_demonstration_link')
  final String? shortYoutubeDemonstrationLinkJson;

  @JsonKey(name: 'in_depth_youtube_explanation_link')
  final String? inDepthYoutubeExplanationLinkJson;

  // NOT part of the raw API response: the exercises endpoint has no image
  // of its own, so this is attached in the data source from the random
  // muscle (API 2) used to fetch this exact list.
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String? muscleImageJson;

  const ExerciseModel({
    required this.idJson,
    required this.nameJson,
    required this.difficultyLevelJson,
    required this.targetMuscleGroupJson,
    required this.primeMoverMuscleJson,
    this.secondaryMuscleJson,
    this.tertiaryMuscleJson,
    this.primaryEquipmentJson,
    this.secondaryEquipmentJson,
    this.posture,
    this.shortYoutubeDemonstrationLinkJson,
    this.inDepthYoutubeExplanationLinkJson,
    this.muscleImageJson,
  }) : super(
         id: idJson,
         name: nameJson,
         difficultyLevel: difficultyLevelJson,
         targetMuscleGroup: targetMuscleGroupJson,
         primeMoverMuscle: primeMoverMuscleJson,
         secondaryMuscle: secondaryMuscleJson,
         tertiaryMuscle: tertiaryMuscleJson,
         primaryEquipment: primaryEquipmentJson,
         secondaryEquipment: secondaryEquipmentJson,
         posture: posture,
         shortYoutubeDemonstrationLink: shortYoutubeDemonstrationLinkJson,
         inDepthYoutubeExplanationLink: inDepthYoutubeExplanationLinkJson,
         muscleImage: muscleImageJson,
       );

  factory ExerciseModel.fromJson(Map<String, dynamic> json) =>
      _$ExerciseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExerciseModelToJson(this);

  /// Used by the data source to attach the muscle image after the exercise
  /// list has already been parsed from json.
  ExerciseModel copyWithMuscleImage(String? muscleImage) {
    return ExerciseModel(
      idJson: idJson,
      nameJson: nameJson,
      difficultyLevelJson: difficultyLevelJson,
      targetMuscleGroupJson: targetMuscleGroupJson,
      primeMoverMuscleJson: primeMoverMuscleJson,
      secondaryMuscleJson: secondaryMuscleJson,
      tertiaryMuscleJson: tertiaryMuscleJson,
      primaryEquipmentJson: primaryEquipmentJson,
      secondaryEquipmentJson: secondaryEquipmentJson,
      posture: posture,
      shortYoutubeDemonstrationLinkJson: shortYoutubeDemonstrationLinkJson,
      inDepthYoutubeExplanationLinkJson: inDepthYoutubeExplanationLinkJson,
      muscleImageJson: muscleImage,
    );
  }
}

@JsonSerializable()
class ExercisesResponse {
  final String message;
  final int totalExercises;
  final int totalPages;
  final int currentPage;
  final List<ExerciseModel> exercises;

  const ExercisesResponse({
    required this.message,
    required this.totalExercises,
    required this.totalPages,
    required this.currentPage,
    required this.exercises,
  });

  factory ExercisesResponse.fromJson(Map<String, dynamic> json) =>
      _$ExercisesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ExercisesResponseToJson(this);
}