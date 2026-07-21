import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/featrures/food/domain/entities/meal_categories_entity.dart';
import 'package:flowery/featrures/food/domain/entities/meal_details_entity.dart';
import 'package:flowery/featrures/food/domain/entities/meal_entity.dart';

abstract interface class FoodRepoContract {
  Future<Result<MealCategoriesEntity>> getMealsCategories();
  Future<Result<List<MealEntity>>> selectCategory(String category);
  Future<Result<MealDetailsEntity>> getMealDetails(String mealId);
}
