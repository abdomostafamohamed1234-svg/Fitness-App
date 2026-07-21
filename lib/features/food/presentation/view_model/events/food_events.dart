sealed class FoodEvents {}

class GetMealsCategoriesEvent extends FoodEvents {}

class SelectMealCategoryEvent extends FoodEvents {
  final String newSelectedCategory;
  final String oldSelectedCategory;

  SelectMealCategoryEvent({
    required this.newSelectedCategory,
    required this.oldSelectedCategory,
  });
}

class GetMealDetailsEvent extends FoodEvents {
  final String mealId;

  GetMealDetailsEvent({required this.mealId});
}
