import 'package:dio/dio.dart';
import 'package:flowery/config/di/di_config.dart';
import 'package:flowery/config/helpers/shared_preferences/shared_preferences_helper.dart';
import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/food/api/api_client/food_api_client.dart';
import 'package:flowery/features/food/api/data_sources/food_remote_data_source_impl.dart';
import 'package:flowery/features/food/data/models/responses/meal_categories_response_model.dart';
import 'package:flowery/features/food/data/models/responses/meal_details_response_model.dart';
import 'package:flowery/features/food/data/models/responses/meals_from_category_response_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockFoodApiClient extends Mock implements FoodApiClient {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    getIt.reset();
    SharedPreferences.setMockInitialValues({});
    final sharedPreferences = await SharedPreferences.getInstance();
    getIt.registerSingleton<SharedPreferencesHelper>(
      SharedPreferencesHelper(sharedPreferences),
    );
  });

  tearDown(() => getIt.reset());

  test('returns meal categories from api client', () async {
    final apiClient = MockFoodApiClient();
    when(() => apiClient.getMealsCategories()).thenAnswer(
      (_) async => MealCategoriesResponseModel(
        categories: [Category(strCategory: 'Breakfast')],
      ),
    );
    final dataSource = FoodRemoteDataSourceImpl(apiClient);

    final result = await dataSource.getMealsCategories();

    expect(result, isA<Success<MealCategoriesResponseModel>>());
    expect(
      (result as Success<MealCategoriesResponseModel>)
          .data
          ?.categories
          ?.first
          .strCategory,
      'Breakfast',
    );
  });

  test('returns error result when api client throws DioException', () async {
    final apiClient = MockFoodApiClient();
    when(
      () => apiClient.getMealsCategories(),
    ).thenThrow(DioException(requestOptions: RequestOptions(path: '/test')));
    final dataSource = FoodRemoteDataSourceImpl(apiClient);

    final result = await dataSource.getMealsCategories();

    expect(result, isA<Error<MealCategoriesResponseModel>>());
  });

  test('returns error result when selecting meals fails', () async {
    final apiClient = MockFoodApiClient();
    when(
      () => apiClient.selectMealCategory(any()),
    ).thenThrow(DioException(requestOptions: RequestOptions(path: '/test')));
    final dataSource = FoodRemoteDataSourceImpl(apiClient);

    final result = await dataSource.selectMealCategory('Breakfast');

    expect(result, isA<Error<MealsFromCategoryResponseModel>>());
  });

  test('returns error result when getting details fails', () async {
    final apiClient = MockFoodApiClient();
    when(
      () => apiClient.getMealDetails(any()),
    ).thenThrow(DioException(requestOptions: RequestOptions(path: '/test')));
    final dataSource = FoodRemoteDataSourceImpl(apiClient);

    final result = await dataSource.getMealDetails('1');

    expect(result, isA<Error<MealDetailsResponseModel>>());
  });
}
