import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/featrures/food/domain/entities/meal_details_entity.dart';
import 'package:flowery/featrures/food/domain/repo/food_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetMealDetailsUseCase {
  final FoodRepoContract foodRepo;
  GetMealDetailsUseCase(this.foodRepo);

  Future<Result<MealDetailsEntity>> call(String mealId) {
    return foodRepo.getMealDetails(mealId);
  }
}
