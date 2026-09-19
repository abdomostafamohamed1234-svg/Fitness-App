import 'package:equatable/equatable.dart';

class MealDetailsEntity extends Equatable {
  final String title;
  final String img;
  final Map<String, String> ingredients;
  final String instructions;

  const MealDetailsEntity({
    required this.title,
    required this.img,
    required this.ingredients,
    required this.instructions,
  });
  @override
  List<Object?> get props => [title, img, ingredients, instructions];
}
