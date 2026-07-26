import 'package:flowery/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NutritionItem extends StatelessWidget {
  const NutritionItem({super.key, required this.value, required this.title});

  final String value;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: OutlinedButton(
          onPressed: null,
          child: Column(
            children: [
              Text(
                value,
                style: TextStyle(color: AppColors.whiteColor, fontSize: 12.sp),
              ),
              SizedBox(height: 2.h),
              Text(
                title,
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
