import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/featrures/food/data/models/responses/meal_categories_response_model.dart';
import 'package:flowery/featrures/food/data/models/responses/meal_details_response_model.dart';
import 'package:flowery/featrures/food/data/models/responses/meals_from_category_response_model.dart';

abstract interface class FoodRemoteDataSourceContract {
  Future<Result<MealCategoriesResponseModel>> getMealsCategories();
  Future<Result<MealsFromCategoryResponseModel>> selectMealCategory(
    String category,
  );
  Future<Result<MealDetailsResponseModel>> getMealDetails(String mealId);
}
