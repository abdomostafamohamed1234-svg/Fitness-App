import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/featrures/food/data/data_sources/food_remote_data_source_contract.dart';
import 'package:flowery/featrures/food/data/models/responses/meal_categories_response_model.dart';
import 'package:flowery/featrures/food/data/models/responses/meal_details_response_model.dart';
import 'package:flowery/featrures/food/data/models/responses/meals_from_category_response_model.dart';
import 'package:flowery/featrures/food/domain/entities/meal_categories_entity.dart';
import 'package:flowery/featrures/food/domain/entities/meal_details_entity.dart';
import 'package:flowery/featrures/food/domain/entities/meal_entity.dart';
import 'package:flowery/featrures/food/domain/repo/food_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: FoodRepoContract)
class FoodRepoImpl implements FoodRepoContract {
  final FoodRemoteDataSourceContract foodRemoteDataSourceContract;
  FoodRepoImpl(this.foodRemoteDataSourceContract);

  @override
  Future<Result<MealCategoriesEntity>> getMealsCategories() async {
    final response = await foodRemoteDataSourceContract.getMealsCategories();
    switch (response) {
      case Success<MealCategoriesResponseModel>():
        return Success<MealCategoriesEntity>(data: response.data?.toEntity());
      case Error<MealCategoriesResponseModel>():
        return Error<MealCategoriesEntity>(exception: response.exception);
    }
  }

  @override
  Future<Result<List<MealEntity>>> selectCategory(String category) async {
    final response = await foodRemoteDataSourceContract.selectMealCategory(
      category,
    );
    switch (response) {
      case Success<MealsFromCategoryResponseModel>():
        return Success<List<MealEntity>>(data: response.data?.toEntity());
      case Error<MealsFromCategoryResponseModel>():
        return Error<List<MealEntity>>(exception: response.exception);
    }
  }

  @override
  Future<Result<MealDetailsEntity>> getMealDetails(String mealId) async {
    final response = await foodRemoteDataSourceContract.getMealDetails(mealId);
    switch (response) {
      case Success<MealDetailsResponseModel>():
        return Success<MealDetailsEntity>(
          data: response.data?.meals?[0].toEntity(),
        );
      case Error<MealDetailsResponseModel>():
        return Error<MealDetailsEntity>(exception: response.exception);
    }
  }
}
