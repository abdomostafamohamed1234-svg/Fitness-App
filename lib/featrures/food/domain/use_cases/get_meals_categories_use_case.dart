import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/featrures/food/domain/entities/meal_categories_entity.dart';
import 'package:flowery/featrures/food/domain/repo/food_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetMealsCategoriesUseCase {
  final FoodRepoContract foodRepo;
  GetMealsCategoriesUseCase(this.foodRepo);

  Future<Result<MealCategoriesEntity>> call() {
    return foodRepo.getMealsCategories();
  }
}
