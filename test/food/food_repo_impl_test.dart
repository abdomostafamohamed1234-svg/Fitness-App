import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/food/data/models/responses/meal_categories_response_model.dart';
import 'package:flowery/features/food/data/models/responses/meal_details_response_model.dart';
import 'package:flowery/features/food/data/models/responses/meals_from_category_response_model.dart';
import 'package:flowery/features/food/data/repo/food_repo_impl.dart';
import 'package:flowery/features/food/data/data_sources/food_remote_data_source_contract.dart';
import 'package:flowery/features/food/domain/entities/meal_categories_entity.dart';
import 'package:flowery/features/food/domain/entities/meal_details_entity.dart';
import 'package:flowery/features/food/domain/entities/meal_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFoodRemoteDataSource extends Mock
    implements FoodRemoteDataSourceContract {}

void main() {
  group('FoodRepoImpl', () {
    test('maps categories response to domain entity', () async {
      final dataSource = MockFoodRemoteDataSource();
      when(() => dataSource.getMealsCategories()).thenAnswer(
        (_) async => Success(
          data: MealCategoriesResponseModel(
            categories: [Category(strCategory: 'Breakfast')],
          ),
        ),
      );
      final repo = FoodRepoImpl(dataSource);

      final result = await repo.getMealsCategories();

      expect(result, isA<Success<MealCategoriesEntity>>());
      expect((result as Success<MealCategoriesEntity>).data?.categories, [
        'Breakfast',
      ]);
    });

    test('maps selected category meals response to domain entity', () async {
      final dataSource = MockFoodRemoteDataSource();
      when(() => dataSource.selectMealCategory(any())).thenAnswer(
        (_) async => Success(
          data: MealsFromCategoryResponseModel(
            meals: [
              Meal(
                strMeal: 'Pancakes',
                strMealThumb: 'https://example.com/pancakes.png',
                idMeal: '1',
              ),
            ],
          ),
        ),
      );
      final repo = FoodRepoImpl(dataSource);

      final result = await repo.selectCategory('Breakfast');

      expect(result, isA<Success<List<MealEntity>>>());
      expect(
        (result as Success<List<MealEntity>>).data?.first.title,
        'Pancakes',
      );
    });

    test('maps meal details response to domain entity', () async {
      final dataSource = MockFoodRemoteDataSource();
      when(() => dataSource.getMealDetails(any())).thenAnswer(
        (_) async => const Success(
          data: MealDetailsResponseModel(
            meals: [
              MealDetailsModel(
                strMeal: 'Pancakes',
                strMealThumb: 'https://example.com/pancakes.png',
                strInstructions: 'Bake.',
                strIngredient1: 'Flour',
                strMeasure1: '1 cup',
              ),
            ],
          ),
        ),
      );
      final repo = FoodRepoImpl(dataSource);

      final result = await repo.getMealDetails('1');

      expect(result, isA<Success<MealDetailsEntity>>());
      expect((result as Success<MealDetailsEntity>).data?.title, 'Pancakes');
      expect(result.data?.instructions, 'Bake.');
    });

    test('returns error when categories datasource fails', () async {
      final dataSource = MockFoodRemoteDataSource();
      when(
        () => dataSource.getMealsCategories(),
      ).thenAnswer((_) async => Error(exception: Exception('remote failed')));
      final repo = FoodRepoImpl(dataSource);

      final result = await repo.getMealsCategories();

      expect(result, isA<Error<MealCategoriesEntity>>());
      expect((result as Error<MealCategoriesEntity>).exception, isNotNull);
    });

    test('returns error when meal details datasource fails', () async {
      final dataSource = MockFoodRemoteDataSource();
      when(
        () => dataSource.getMealDetails(any()),
      ).thenAnswer((_) async => Error(exception: Exception('details failed')));
      final repo = FoodRepoImpl(dataSource);

      final result = await repo.getMealDetails('1');

      expect(result, isA<Error<MealDetailsEntity>>());
      expect((result as Error<MealDetailsEntity>).exception, isNotNull);
    });
  });
}
