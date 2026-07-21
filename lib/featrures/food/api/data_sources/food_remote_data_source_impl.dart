import 'package:dio/dio.dart';
import 'package:flowery/config/exception_handlers/dio_exception_handler.dart';
import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/featrures/food/api/api_client/food_api_client.dart';
import 'package:flowery/featrures/food/data/data_sources/food_remote_data_source_contract.dart';
import 'package:flowery/featrures/food/data/models/responses/meal_categories_response_model.dart';
import 'package:flowery/featrures/food/data/models/responses/meal_details_response_model.dart';
import 'package:flowery/featrures/food/data/models/responses/meals_from_category_response_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as:FoodRemoteDataSourceContract)
class FoodRemoteDataSourceImpl implements FoodRemoteDataSourceContract {
  final FoodApiClient foodApiClient;
  FoodRemoteDataSourceImpl(this.foodApiClient);
  @override
  Future<Result<MealCategoriesResponseModel>> getMealsCategories() async {
    try {
      final response = await foodApiClient.getMealsCategories();
      return Success<MealCategoriesResponseModel>(data: response);
    } on DioException catch (e) {
      return Error<MealCategoriesResponseModel>(
        exception: await DioExceptionHandler.handle(e),
      );
    }
  }
  
  @override
  Future<Result<MealsFromCategoryResponseModel>> selectMealCategory(String category) async{
    try {
      final response = await foodApiClient.selectMealCategory(category);
      return Success<MealsFromCategoryResponseModel>(data: response);
    } on DioException catch (e) {
      return Error<MealsFromCategoryResponseModel>(
        exception: await DioExceptionHandler.handle(e),
      );
    }
  }

  @override
  Future<Result<MealDetailsResponseModel>> getMealDetails(String mealId) async{
        try {
      final response = await foodApiClient.getMealDetails(mealId);
      return Success<MealDetailsResponseModel>(data: response);
    } on DioException catch (e) {
      return Error<MealDetailsResponseModel>(
        exception: await DioExceptionHandler.handle(e),
      );
    }
  }
}
