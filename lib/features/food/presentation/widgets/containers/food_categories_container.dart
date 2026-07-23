import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/features/food/domain/entities/meal_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FoodCategoriesContainer extends StatelessWidget {
  final List<MealEntity> foodCategories;
  final ValueChanged<int>? onTap;
  const FoodCategoriesContainer({
    super.key,
    required this.foodCategories,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return TabBar(
      onTap: onTap,
      dividerColor: AppColors.transparent,
      overlayColor: WidgetStateProperty.all(AppColors.transparent),
      labelColor: AppColors.whiteColor,
      indicatorPadding: EdgeInsetsGeometry.symmetric(
        horizontal: -10.w,
        vertical: 3.h,
      ),
      tabAlignment: TabAlignment.start,
      splashFactory: NoSplash.splashFactory,
      indicator: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(50.sp),
      ),

      isScrollable: true,
      tabs: foodCategories
          .map((category) => Tab(text: category.title))
          .toList(),
    );
  }
}
