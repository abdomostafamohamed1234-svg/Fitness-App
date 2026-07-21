import 'package:equatable/equatable.dart';
import 'package:flowery/core/base/base_state.dart';
import 'package:flowery/features/food/domain/entities/meal_categories_entity.dart';
import 'package:flowery/features/food/domain/entities/meal_details_entity.dart';
import 'package:flowery/features/food/domain/entities/meal_entity.dart';

class FoodState extends Equatable {
  final String selectedCategory;
  final BaseState<MealCategoriesEntity> categoriesState;
  final BaseState<List<MealEntity>> mealsState;
  final BaseState<MealDetailsEntity> detailsState;

  const FoodState({
    this.selectedCategory = "",
    this.categoriesState = const BaseState.initial(),
    this.mealsState = const BaseState.initial(),
    this.detailsState = const BaseState.initial(),
  });

  FoodState copyWith({
    BaseState<MealCategoriesEntity>? categoriesState,
    final String? selectedCategory,
    final BaseState<List<MealEntity>>? mealsState,
    final BaseState<MealDetailsEntity>? detailsState,
  }) {
    return FoodState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
      categoriesState: categoriesState ?? this.categoriesState,
      mealsState: mealsState ?? this.mealsState,
      detailsState: detailsState ?? this.detailsState,
    );
  }

  @override
  List<Object?> get props => [
    categoriesState,
    selectedCategory,
    mealsState,
    detailsState,
  ];
}
