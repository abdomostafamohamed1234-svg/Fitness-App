import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/core/base/base_state.dart';
import 'package:flowery/features/food/domain/entities/meal_details_entity.dart';
import 'package:flowery/features/food/domain/entities/meal_entity.dart';
import 'package:flowery/features/food/domain/repo/food_repo_contract.dart';
import 'package:flowery/features/food/domain/use_cases/get_meal_details_use_case.dart';
import 'package:flowery/features/food/domain/use_cases/get_meals_categories_use_case.dart';
import 'package:flowery/features/food/domain/use_cases/select_meals_category_use_case.dart';
import 'package:flowery/features/food/presentation/view_model/cubit/food_cubit.dart';
import 'package:flowery/features/food/presentation/view_model/events/food_events.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFoodRepo extends Mock implements FoodRepoContract {}

void main() {
  group('FoodCubit', () {
    late FoodCubit cubit;
    late MockFoodRepo repo;

    setUp(() {
      repo = MockFoodRepo();
      when(() => repo.getMealsCategories()).thenAnswer(
        (_) async => const Success(
          data: [
            MealEntity(title: 'Breakfast', img: 'Breakfast.png', id: '1'),
            MealEntity(title: 'Pasta', img: 'pasta.png', id: '2'),
          ],
        ),
      );
      when(() => repo.selectCategory(any())).thenAnswer(
        (_) async => const Success(
          data: [
            MealEntity(
              title: 'Pancakes',
              img: 'https://example.com/pancakes.png',
              id: '1',
            ),
          ],
        ),
      );
      when(() => repo.getMealDetails(any())).thenAnswer(
        (_) async => const Success(
          data: MealDetailsEntity(
            title: 'Pancakes',
            img: 'https://example.com/pancakes.png',
            ingredients: {'strIngredient1': 'Flour'},
            instructions: 'Bake it.',
          ),
        ),
      );
      cubit = FoodCubit(
        GetMealsCategoriesUseCase(repo),
        SelectMealsCategoryUseCase(repo),
        GetMealDetailsUseCase(repo),
      );
    });

    test('loads categories and selects first one', () async {
      cubit.doEvent(GetMealsCategoriesEvent());
      await Future<void>.delayed(Duration.zero);

      expect(cubit.state.categoriesState.state, StateType.success);
      expect(cubit.state.selectedCategory, 'Breakfast');
      expect(cubit.state.mealsState.state, StateType.success);
    });

    test('loads meals for a selected category', () async {
      cubit.doEvent(
        SelectMealCategoryEvent(
          oldSelectedCategory: '',
          newSelectedCategory: 'Breakfast',
        ),
      );
      await Future<void>.delayed(Duration.zero);

      expect(cubit.state.mealsState.state, StateType.success);
      expect(cubit.state.mealsState.data, isNotNull);
      expect(cubit.state.mealsState.data!.first.title, 'Pancakes');
    });

    test('loads meal details', () async {
      cubit.doEvent(GetMealDetailsEvent(mealId: '1'));
      await Future<void>.delayed(Duration.zero);

      expect(cubit.state.detailsState.state, StateType.success);
      expect(cubit.state.detailsState.data, isNotNull);
      expect(cubit.state.detailsState.data!.title, 'Pancakes');
    });

    test('emits error state when categories request fails', () async {
      when(() => repo.getMealsCategories()).thenAnswer(
        (_) async => Error(exception: Exception('categories failed')),
      );
      final failingCubit = FoodCubit(
        GetMealsCategoriesUseCase(repo),
        SelectMealsCategoryUseCase(repo),
        GetMealDetailsUseCase(repo),
      );

      failingCubit.doEvent(GetMealsCategoriesEvent());
      await Future<void>.delayed(Duration.zero);

      expect(failingCubit.state.categoriesState.state, StateType.error);
      expect(failingCubit.state.categoriesState.exception, isNotNull);
    });

    test('emits error state when meal details request fails', () async {
      when(
        () => repo.getMealDetails(any()),
      ).thenAnswer((_) async => Error(exception: Exception('details failed')));
      final failingCubit = FoodCubit(
        GetMealsCategoriesUseCase(repo),
        SelectMealsCategoryUseCase(repo),
        GetMealDetailsUseCase(repo),
      );

      failingCubit.doEvent(GetMealDetailsEvent(mealId: '1'));
      await Future<void>.delayed(Duration.zero);

      expect(failingCubit.state.detailsState.state, StateType.error);
      expect(failingCubit.state.detailsState.exception, isNotNull);
    });
  });
}
