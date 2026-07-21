import 'package:dio/dio.dart';
import 'package:flowery/config/api/api_endpoints.dart';
import 'package:flowery/config/api/api_keys.dart';
import 'package:flowery/featrures/food/data/models/responses/meal_categories_response_model.dart';
import 'package:flowery/featrures/food/data/models/responses/meal_details_response_model.dart';
import 'package:flowery/featrures/food/data/models/responses/meals_from_category_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'food_api_client.g.dart';

@injectable
@RestApi()
abstract class FoodApiClient {
  @factoryMethod
  factory FoodApiClient(@Named(AppEndPoints.mealsDio) Dio dio) = _FoodApiClient;

  @GET(AppEndPoints.mealCategories)
  Future<MealCategoriesResponseModel> getMealsCategories();

  @GET(AppEndPoints.mealsByCategory)
  Future<MealsFromCategoryResponseModel> selectMealCategory(
    @Query(ApiKeys.category) String category,
  );

    @GET(AppEndPoints.mealDetails)
  Future<MealDetailsResponseModel> getMealDetails(
    @Query(ApiKeys.mealId) String mealId,
  );
}
