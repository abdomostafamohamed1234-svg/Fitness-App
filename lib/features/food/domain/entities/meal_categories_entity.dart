import 'package:equatable/equatable.dart';
import 'package:flowery/features/food/domain/entities/meal_entity.dart';

class MealCategoriesEntity extends Equatable{
  final List<MealEntity> categories;

  const MealCategoriesEntity({required this.categories});
  
  @override
  List<Object?> get props => [categories];
}
