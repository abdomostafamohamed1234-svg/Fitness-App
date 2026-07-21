import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/base/base_state.dart';
import 'package:flowery/featrures/food/domain/entities/meal_categories_entity.dart';
import 'package:flowery/featrures/food/domain/entities/meal_entity.dart';
import 'package:flowery/featrures/food/domain/repo/food_repo_contract.dart';
import 'package:flowery/featrures/food/domain/use_cases/get_meal_details_use_case.dart';
import 'package:flowery/featrures/food/domain/use_cases/get_meals_categories_use_case.dart';
import 'package:flowery/featrures/food/domain/use_cases/select_meals_category_use_case.dart';
import 'package:flowery/featrures/food/presentation/screens/food_recommendation_screen.dart';
import 'package:flowery/featrures/food/presentation/view_model/cubit/food_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFoodRepo extends Mock implements FoodRepoContract {}

Widget _buildScreen(FoodCubit cubit) {
  return ScreenUtilInit(
    designSize: const Size(390, 844),
    minTextAdapt: true,
    builder: (_, _) {
      return MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: BlocProvider.value(
          value: cubit,
          child: const FoodRecommendationScreen(),
        ),
      );
    },
  );
}

void main() {
  testWidgets('shows recommendation title, categories, and meals', (
    tester,
  ) async {
    final repo = MockFoodRepo();
    final cubit = FoodCubit(
      GetMealsCategoriesUseCase(repo),
      SelectMealsCategoryUseCase(repo),
      GetMealDetailsUseCase(repo),
    );

    cubit.emit(
      cubit.state.copyWith(
        categoriesState: const BaseState.success(
          MealCategoriesEntity(categories: ['Breakfast', 'Lunch']),
        ),
        mealsState: BaseState.success(
          List.generate(
            20,
            (index) => MealEntity(
              title: 'Pancakes $index',
              img: 'https://example.com/pancakes.png',
              id: '$index',
            ),
          ),
        ),
      ),
    );

    await tester.pumpWidget(_buildScreen(cubit));
    await tester.pump();

    expect(find.text('Food Recommendation'), findsOneWidget);
    expect(find.text('Breakfast'), findsOneWidget);
    expect(find.text('Lunch'), findsOneWidget);
    expect(find.text('Pancakes 0'), findsOneWidget);
  });

  testWidgets('shows error text when categories state is error', (
    tester,
  ) async {
    final repo = MockFoodRepo();
    final cubit = FoodCubit(
      GetMealsCategoriesUseCase(repo),
      SelectMealsCategoryUseCase(repo),
      GetMealDetailsUseCase(repo),
    );

    cubit.emit(
      cubit.state.copyWith(
        categoriesState: BaseState.error(
          Exception('Failed to load categories'),
        ),
      ),
    );

    await tester.pumpWidget(_buildScreen(cubit));
    await tester.pump();

    expect(find.textContaining('Failed to load categories'), findsOneWidget);
  });
}
