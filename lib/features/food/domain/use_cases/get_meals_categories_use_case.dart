import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/food/domain/entities/meal_entity.dart';
import 'package:flowery/features/food/domain/repo/food_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetMealsCategoriesUseCase {
  final FoodRepoContract foodRepo;
  GetMealsCategoriesUseCase(this.foodRepo);

  Future<Result<List<MealEntity>>> call() {
    return foodRepo.getMealsCategories();
  }
}
