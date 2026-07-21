class MealDetailsEntity {
  final String title;
  final String img;
  final Map<String, String> ingredients;
  final String instructions;

  MealDetailsEntity({
    required this.title,
    required this.img,
    required this.ingredients,
    required this.instructions,
  });
}
