import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/config/routing/app_routes.dart';
import 'package:flowery/config/routing/routing_extensions.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/core/widgets/glass_container.dart';
import 'package:flowery/features/on_boarding/presentation/view_model/cubit/on_boarding_cubit.dart';
import 'package:flowery/features/on_boarding/presentation/view_model/events/on_boarding_events.dart';
import 'package:flowery/features/on_boarding/presentation/view_model/state/on_boarding_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BlurredContainer extends StatelessWidget {
  final OnBoardingState state;
  final AppLocalizations localizations;
  final TextTheme textTheme;
  final PageController controller;
  const BlurredContainer({
    super.key,
    required this.state,
    required this.localizations,
    required this.textTheme,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      children: [
        // Title
        state.pageNumber == 0
            ? Text(
                localizations.motivation_title_1,
                style: textTheme.headlineLarge,
                textAlign: TextAlign.center,
              )
            : state.pageNumber == 1
            ? Text(
                localizations.motivation_title_2,
                style: textTheme.headlineLarge,
                textAlign: TextAlign.center,
              )
            : Text(
                localizations.motivation_title_3,
                style: textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),

        SizedBox(height: 20.h),
        // Motivation
        Text(localizations.motivation, style: textTheme.bodyMedium),
        SizedBox(height: 20.h),

        // Dots
        SmoothPageIndicator(
          controller: controller,
          count: 3,
          effect: ExpandingDotsEffect(
            dotHeight: 8.h,
            dotWidth: 8.w,
            dotColor: AppColors.whiteColor,
          ),
        ),

        SizedBox(height: 10.h),

        // Buttons
        state.pageNumber == 0
            ? SizedBox(
                height: 40.h,
                width: 343.w,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<OnBoardingCubit>().doEvent(
                      ChangePageEvent(pageNumber: 1),
                    );
                  },
                  child: Text(localizations.next),
                ),
              )
            : state.pageNumber == 1
            ? Row(
                spacing: 150.sp,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 40.h,
                      child: OutlinedButton(
                        onPressed: () {
                          context.read<OnBoardingCubit>().doEvent(
                            ChangePageEvent(pageNumber: 0),
                          );
                        },
                        child: Text(localizations.back),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 40.h,
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<OnBoardingCubit>().doEvent(
                            ChangePageEvent(pageNumber: 2),
                          );
                        },
                        child: Text(localizations.next),
                      ),
                    ),
                  ),
                ],
              )
            : Row(
                spacing: 150.sp,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 40.h,
                      child: OutlinedButton(
                        onPressed: () {
                          context.read<OnBoardingCubit>().doEvent(
                            ChangePageEvent(pageNumber: 1),
                          );
                        },
                        child: Text(localizations.back),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 40.h,
                      child: ElevatedButton(
                        onPressed: () {
                          context.pushNamed(AppRoutes.login);
                        },
                        child: Text(localizations.do_it),
                      ),
                    ),
                  ),
                ],
              ),
      ],
    );
  }
}
