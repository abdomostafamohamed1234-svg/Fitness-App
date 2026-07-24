import 'package:flowery/core/theme/app-assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flowery/config/routing/app_routes.dart';

import 'categories_list_section.dart';
import 'workouts_grid_section.dart';

class WorkoutsBody extends StatelessWidget {
  const WorkoutsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(AssetsImage.workoutsBackGround, fit: BoxFit.cover),
        ),
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 16.h),
              Row(
                children: [
                  IconButton(
                       onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.Home);
                  },
            
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  SizedBox(width: 16.w),
                  Text(
                    'Workouts',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              const CategoriesListSection(),
              SizedBox(height: 24.h),
              const WorkoutsGridSection(),
            ],
          ),
        ),
      ],
    );
  }
}
