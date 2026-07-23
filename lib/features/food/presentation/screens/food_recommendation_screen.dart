import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/features/food/domain/entities/meal_entity.dart';
import 'package:flowery/features/food/presentation/assets/food_assets_navigation.dart';
import 'package:flowery/features/food/presentation/view_model/cubit/food_cubit.dart';
import 'package:flowery/features/food/presentation/view_model/events/food_events.dart';
import 'package:flowery/features/food/presentation/view_model/state/food_state.dart';
import 'package:flowery/features/food/presentation/widgets/Images/blurred_background_image.dart';
import 'package:flowery/features/food/presentation/widgets/headers/page_header.dart';
import 'package:flowery/features/food/presentation/widgets/containers/food_categories_container.dart';
import 'package:flowery/features/food/presentation/widgets/items/food_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FoodRecommendationScreen extends StatefulWidget {
  const FoodRecommendationScreen({super.key});

  @override
  State<FoodRecommendationScreen> createState() =>
      _FoodRecommendationScreenState();
}

class _FoodRecommendationScreenState extends State<FoodRecommendationScreen> {
  late TextTheme textTheme;
  late AppLocalizations localizations;

  @override
  void didChangeDependencies() {
    textTheme = Theme.of(context).textTheme;
    localizations = AppLocalizations.of(context)!;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoodCubit, FoodState>(
      buildWhen: (previous, current) {
        return current.categoriesState != previous.categoriesState ||
        current.mealsState != previous.mealsState;
      },
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              const BlurredBackgroundImage(
                image: FoodAssetsNavigation.background,
                blurStrength: 3,
              ),
              state.categoriesState.when(
                initial: () {
                  return SafeArea(
                    child: Center(
                      child: SizedBox(
                        height: 50.h,
                        width: 50.w,
                        child: const CircularProgressIndicator(),
                      ),
                    ),
                  );
                },
                loading: () {
                  return SafeArea(
                    child: Center(
                      child: SizedBox(
                        height: 50.h,
                        width: 50.w,
                        child: const CircularProgressIndicator(),
                      ),
                    ),
                  );
                },
                error: (Exception exception) {
                  return SafeArea(
                    child: Center(child: Text(exception.toString())),
                  );
                },
                success: (List<MealEntity> data) {
                  return DefaultTabController(
                    length: data.length,
                    child: SafeArea(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              PageHeader(
                                style: textTheme.headlineLarge,
                                title: localizations.food_recommendation,
                              ),
                              SizedBox(height: 20.h),
                              FoodCategoriesContainer(
                                foodCategories: data,
                                onTap: (value) =>
                                    context.read<FoodCubit>().doEvent(
                                      SelectMealCategoryEvent(
                                        oldSelectedCategory:
                                            state.selectedCategory,
                                        newSelectedCategory: data[value].title,
                                      ),
                                    ),
                              ),
                              SizedBox(height: 20.h),
                              state.mealsState.when(
                                success: (List<MealEntity> data) {
                                  return Expanded(
                                    child: GridView.builder(
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 20,
                                            mainAxisSpacing: 20,
                                          ),
                                      itemBuilder: (context, index) => FoodItem(
                                        style: textTheme.titleMedium,
                                        foodImageUrl: data[index].img,
                                        foodTitle: data[index].title,
                                        mealId: data[index].id,
                                      ),
                                      itemCount: data.length,
                                    ),
                                  );
                                },
                                loading: () {
                                  return Expanded(
                                    child: Center(
                                      child: SizedBox(
                                        height: 50.h,
                                        width: 50.w,
                                        child:
                                            const CircularProgressIndicator(),
                                      ),
                                    ),
                                  );
                                },
                                error: (Exception exception) {
                                  return Expanded(
                                    child: Center(
                                      child: Text(exception.toString()),
                                    ),
                                  );
                                },
                                initial: () {
                                  return const SizedBox.shrink();
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
