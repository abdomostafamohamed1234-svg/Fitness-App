import 'package:flowery/features/on_boarding/presentation/assets/on_boarding_assets_navigation.dart';
import 'package:flowery/features/on_boarding/presentation/view_model/cubit/on_boarding_cubit.dart';
import 'package:flowery/features/on_boarding/presentation/view_model/events/on_boarding_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PoseImage extends StatelessWidget {
  final List<Widget> poses = [
    const Image(image: AssetImage(OnBoardingAssetsNavigation.pose1)),
    const Image(image: AssetImage(OnBoardingAssetsNavigation.pose2)),
    const Image(image: AssetImage(OnBoardingAssetsNavigation.pose3)),
  ];
  final PageController controller;
  PoseImage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Transform.scale(
            scale: 1.5,
            child: SizedBox(
              height: 594.h,
              child: PageView(
                onPageChanged: (value) {
                  context.read<OnBoardingCubit>().doEvent(
                    ChangePageEvent(pageNumber: value),
                  );
                },
                controller: controller,
                children: poses,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
