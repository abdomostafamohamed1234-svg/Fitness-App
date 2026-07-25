import 'package:equatable/equatable.dart';

/// Full exercise info coming from API 3 (exercises/by-muscle-difficulty).
/// We keep ALL fields (even the ones not shown in the "Popular Training"
/// card) so this same entity can be passed later to an exercise-details
/// screen without having to re-fetch anything.
class ExerciseEntity extends Equatable {
  final String id;
  final String name;
  final String difficultyLevel;
  final String targetMuscleGroup;
  final String primeMoverMuscle;
  final String? secondaryMuscle;
  final String? tertiaryMuscle;
  final String? primaryEquipment;
  final String? secondaryEquipment;
  final String? posture;
  final String? shortYoutubeDemonstrationLink;
  final String? inDepthYoutubeExplanationLink;

  /// NOTE: the exercises endpoint itself does NOT return an image.
  /// The only image we have is the one that came back with the random
  /// muscle (API 2) that was used to fetch this exact list, so we attach
  /// it here to every exercise in the group.
  final String? muscleImage;

  const ExerciseEntity({
    required this.id,
    required this.name,
    required this.difficultyLevel,
    required this.targetMuscleGroup,
    required this.primeMoverMuscle,
    this.secondaryMuscle,
    this.tertiaryMuscle,
    this.primaryEquipment,
    this.secondaryEquipment,
    this.posture,
    this.shortYoutubeDemonstrationLink,
    this.inDepthYoutubeExplanationLink,
    this.muscleImage,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    difficultyLevel,
    targetMuscleGroup,
    primeMoverMuscle,
    secondaryMuscle,
    tertiaryMuscle,
    primaryEquipment,
    secondaryEquipment,
    posture,
    shortYoutubeDemonstrationLink,
    inDepthYoutubeExplanationLink,
    muscleImage,
  ];
}