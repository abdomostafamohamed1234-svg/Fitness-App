import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/food/domain/entities/meal_details_entity.dart';
import 'package:flowery/features/food/domain/entities/meal_entity.dart';

abstract interface class FoodRepoContract {
  Future<Result<List<MealEntity>>> getMealsCategories();
  Future<Result<List<MealEntity>>> selectCategory(String category);
  Future<Result<MealDetailsEntity>> getMealDetails(String mealId);
}
