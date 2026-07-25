class RecommendationModel {
  final String message;
  final int totalMuscles;
  final List<MuscleModel> muscles;

  RecommendationModel({
    required this.message,
    required this.totalMuscles,
    required this.muscles,
  });
}

class MuscleModel {
  final String id;
  final String name;
  final String? image;

  MuscleModel({
    required this.id,
    required this.name,
    this.image,
  });
}