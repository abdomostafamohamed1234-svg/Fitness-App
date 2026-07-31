import 'package:flowery/config/di/di_config.dart';
import 'package:flowery/core/theme/app_assets.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/features/app_sections/domain/entities/custom_nav_item_model.dart';
import 'package:flowery/features/app_sections/presentation/view/widgets/custom_nav_bar.dart';
import 'package:flowery/features/app_sections/presentation/view_model/cubit/app_sections_cubit.dart';
import 'package:flowery/features/app_sections/presentation/view_model/cubit/app_sections_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppSectionsPage extends StatelessWidget {
  const AppSectionsPage({super.key});

  static final List<CustomNavItemModel> _navItems = [
    CustomNavItemModel(
      getLabel: (l10n) => l10n.navExplore,
      icon: AppAssets.homeIconSvg,
    ),
    CustomNavItemModel(
      getLabel: (l10n) => l10n.navChat,
      icon: AppAssets.chatIconSvg,
    ),
    CustomNavItemModel(
      getLabel: (l10n) => l10n.navWorkouts,
      icon: AppAssets.workoutIconSvg,
    ),
    CustomNavItemModel(
      getLabel: (l10n) => l10n.navProfile,
      icon: AppAssets.profileIconSvg,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AppSectionsCubit>(),
      child: Scaffold(
        extendBody: true, // Allows background images to extend under the navbar
        body: BlocBuilder<AppSectionsCubit, AppSectionsStates>(
          builder: (context, state) {
            final cubit = context.read<AppSectionsCubit>();
            return PageView(
              controller: cubit.pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                Center(
                  child: Text(
                    'Home Screen',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 25,
                    ),
                  ),
                ), // 1: Chat
                Center(
                  child: Text(
                    'Chat Screen',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 25,
                    ),
                  ),
                ), // 1: Chat
                Center(
                  child: Text(
                    'Workouts Screen',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 25,
                    ),
                  ),
                ), // 2: Workouts
                Center(
                  child: Text(
                    'Profile Screen',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 25,
                    ),
                  ),
                ), // 3: Profile
              ],
            );
          },
        ),
        bottomNavigationBar: BlocBuilder<AppSectionsCubit, AppSectionsStates>(
          builder: (context, state) {
            final cubit = context.read<AppSectionsCubit>();
            return CustomNavBar(
              items: _navItems,
              currentIndex: state.currentIndex,
              onTap: cubit.setCurrentIndex,
            );
          },
        ),
      ),
    );
  }
}