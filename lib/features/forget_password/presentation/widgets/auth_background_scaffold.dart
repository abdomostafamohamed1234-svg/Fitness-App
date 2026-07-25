import 'dart:ui';

import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/core/widgets/glass_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthBackgroundScaffold extends StatelessWidget {
  final String label;
  final List<Widget> children;
  final Widget? bottomWidget;

  const AuthBackgroundScaffold({
    super.key,
    required this.label,
    required this.children,
    this.bottomWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        elevation: 0,
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.whiteColor),
                onPressed: () => Navigator.pop(context),
              )
            : null,
        title: Text(
          label,
          style: TextStyle(color: AppColors.whiteColor, fontSize: 14.sp),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Background blur image
          Positioned.fill(
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: Image.asset(
                'assets/on_boarding_background.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Slight darken overlay so text/inputs stay readable
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(color:AppColors.transparent),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 60.h),
                  GlassContainer(children: children),
                  if (bottomWidget != null) ...[
                    SizedBox(height: 20.h),
                    bottomWidget!,
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
