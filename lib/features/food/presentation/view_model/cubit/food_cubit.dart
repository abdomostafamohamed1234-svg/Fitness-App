import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/core/base/base_state.dart';
import 'package:flowery/features/food/domain/entities/meal_details_entity.dart';
import 'package:flowery/features/food/domain/entities/meal_entity.dart';
import 'package:flowery/features/food/domain/use_cases/get_meal_details_use_case.dart';
import 'package:flowery/features/food/domain/use_cases/get_meals_categories_use_case.dart';
import 'package:flowery/features/food/domain/use_cases/select_meals_category_use_case.dart';
import 'package:flowery/features/food/presentation/view_model/events/food_events.dart';
import 'package:flowery/features/food/presentation/view_model/state/food_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class FoodCubit extends Cubit<FoodState> {
  final GetMealsCategoriesUseCase _getMealsCategoriesUseCase;
  final SelectMealsCategoryUseCase _selectMealsCategoryUseCase;
  final GetMealDetailsUseCase _getMealDetailsUseCase;
  FoodCubit(
    this._getMealsCategoriesUseCase,
    this._selectMealsCategoryUseCase,
    this._getMealDetailsUseCase,
  ) : super(const FoodState());

  void doEvent(FoodEvents event) {
    switch (event) {
      case GetMealsCategoriesEvent():
        _getMealsCategories();
      case SelectMealCategoryEvent():
        _selectMealCategory(event);
      case GetMealDetailsEvent():
        _getMealDetails(event);
    }
  }

  void _getMealDetails(GetMealDetailsEvent event) async {
    emit(state.copyWith(detailsState: const BaseState.loading()));
    final response = await _getMealDetailsUseCase(event.mealId);
    switch (response) {
      case Success<MealDetailsEntity>():
        emit(state.copyWith(detailsState: BaseState.success(response.data)));
      case Error<MealDetailsEntity>():
        emit(state.copyWith(detailsState: BaseState.error(response.exception)));
    }
  }

  void _selectMealCategory(SelectMealCategoryEvent event) async {
    emit(state.copyWith(selectedCategory: event.newSelectedCategory));

    if (event.newSelectedCategory != event.oldSelectedCategory) {
      emit(state.copyWith(mealsState: const BaseState.loading()));
      final response = await _selectMealsCategoryUseCase.call(
        event.newSelectedCategory,
      );
      switch (response) {
        case Success<List<MealEntity>>():
          emit(state.copyWith(mealsState: BaseState.success(response.data)));
        case Error<List<MealEntity>>():
          emit(state.copyWith(mealsState: BaseState.error(response.exception)));
      }
    }
  }

  void _getMealsCategories() async {
    emit(state.copyWith(categoriesState: const BaseState.loading()));
    final response = await _getMealsCategoriesUseCase.call();
    switch (response) {
      case Success<List<MealEntity>>():
        emit(state.copyWith(categoriesState: BaseState.success(response.data)));
        if (state.mealsState.data == null) {
          _selectMealCategory(
            SelectMealCategoryEvent(
              oldSelectedCategory: "",
              newSelectedCategory: response.data?[0].title ?? "",
            ),
          );
        }
      case Error<List<MealEntity>>():
        emit(
          state.copyWith(categoriesState: BaseState.error(response.exception)),
        );
    }
  }
}
