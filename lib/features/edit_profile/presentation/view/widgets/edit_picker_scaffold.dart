import 'package:flowery/core/theme/app_assets.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditPickerScaffold extends StatelessWidget {
  const EditPickerScaffold({
    super.key,
    required this.title,
    required this.child,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transparent,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              AppAssets.registerBackGround,
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24.h),
                  Center(
                    child: Image.asset(AppAssets.fitnessSplash, height: 90.h, width: 90.h),
                  ),
                  SizedBox(height: 30.h),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  if (subtitle != null) ...[
                    SizedBox(height: 4.h),
                    Text(
                      subtitle!,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 12.sp),
                    ),
                  ],
                  SizedBox(height: 24.h),
                  Expanded(child: SingleChildScrollView(child: child)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
