class ExerciseScreenArgs {
  final String muscleId;
  final String muscleName;
  final String? backgroundImageUrl;
  final String? trainerImageUrl;

  const ExerciseScreenArgs({
    required this.muscleId,
    required this.muscleName,
    this.backgroundImageUrl,
    this.trainerImageUrl,
  });
}