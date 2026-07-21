import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/featrures/food/presentation/screens/food_details_screen.dart';
import 'package:flowery/featrures/food/presentation/view_model/cubit/food_cubit.dart';
import 'package:flowery/featrures/food/presentation/view_model/events/food_events.dart';
import 'package:flowery/featrures/food/presentation/widgets/Images/custom_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FoodItem extends StatelessWidget {
  final TextStyle? style;
  final String foodImageUrl;
  final String foodTitle;
  final String mealId;
  const FoodItem({
    super.key,
    required this.style,
    required this.foodImageUrl,
    required this.foodTitle,
    required this.mealId,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          context.read<FoodCubit>().doEvent(
            GetMealDetailsEvent(mealId: mealId),
          );

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: context.read<FoodCubit>(),
                child: const FoodDetailsScreen(),
              ),
            ),
          );
        },
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(20),
              child: CustomCachedNetworkImage(imageUrl: foodImageUrl),
            ),
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(20),
              child: Opacity(
                opacity: 0.5,
                child: Container(color: AppColors.blackColor),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 100.w,
                  child: Text(
                    foodTitle,
                    style: style,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
