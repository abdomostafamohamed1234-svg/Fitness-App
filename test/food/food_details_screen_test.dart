import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/base/base_state.dart';
import 'package:flowery/features/food/domain/entities/meal_details_entity.dart';
import 'package:flowery/features/food/domain/repo/food_repo_contract.dart';
import 'package:flowery/features/food/domain/use_cases/get_meal_details_use_case.dart';
import 'package:flowery/features/food/domain/use_cases/get_meals_categories_use_case.dart';
import 'package:flowery/features/food/domain/use_cases/select_meals_category_use_case.dart';
import 'package:flowery/features/food/presentation/screens/food_details_screen.dart';
import 'package:flowery/features/food/presentation/view_model/cubit/food_cubit.dart';
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
          child: const FoodDetailsScreen(),
        ),
      );
    },
  );
}

void main() {
  testWidgets('shows meal details content', (tester) async {
    final repo = MockFoodRepo();
    final cubit = FoodCubit(
      GetMealsCategoriesUseCase(repo),
      SelectMealsCategoryUseCase(repo),
      GetMealDetailsUseCase(repo),
    );

    cubit.emit(
      cubit.state.copyWith(
        detailsState: const BaseState.success(
          MealDetailsEntity(
            title: 'Greek Salad',
            img: 'https://example.com/salad.png',
            ingredients: {'strIngredient1': 'Tomato', 'strMeasure1': '2'},
            instructions: 'Mix the ingredients and serve.',
          ),
        ),
      ),
    );

    await tester.pumpWidget(_buildScreen(cubit));
    await tester.pump();

    expect(find.text('Greek Salad'), findsOneWidget);
    expect(find.text('Mix the ingredients and serve.'), findsOneWidget);
    expect(find.text('Instructions'), findsOneWidget);
    expect(find.text('Ingredients'), findsOneWidget);
  });

  testWidgets('shows error text when details state is error', (tester) async {
    final repo = MockFoodRepo();
    final cubit = FoodCubit(
      GetMealsCategoriesUseCase(repo),
      SelectMealsCategoryUseCase(repo),
      GetMealDetailsUseCase(repo),
    );

    cubit.emit(
      cubit.state.copyWith(
        detailsState: BaseState.error(Exception('Failed to load details')),
      ),
    );

    await tester.pumpWidget(_buildScreen(cubit));
    await tester.pump();

    expect(find.textContaining('Failed to load details'), findsOneWidget);
  });
}
