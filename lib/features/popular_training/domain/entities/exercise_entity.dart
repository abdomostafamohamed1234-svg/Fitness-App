import 'package:equatable/equatable.dart';

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