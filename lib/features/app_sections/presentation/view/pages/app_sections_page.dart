import 'package:flowery/config/di/di_config.dart';
import 'package:flowery/core/theme/app_assets.dart';
import 'package:flowery/features/app_sections/domain/entities/custom_nav_item_model.dart';
import 'package:flowery/features/app_sections/presentation/view/widgets/custom_nav_bar.dart';
import 'package:flowery/features/app_sections/presentation/view_model/cubit/app_sections_cubit.dart';
import 'package:flowery/features/app_sections/presentation/view_model/cubit/app_sections_states.dart';
import 'package:flowery/features/chat_bot/presentation/screens/chat_bot_screen.dart';
import 'package:flowery/features/home/presentation/view/screen/home_Page.dart';
import 'package:flowery/features/home/presentation/view_model/home_event.dart'
    hide GetProfileDataEvent;
import 'package:flowery/features/profile/presentation/view/screen/profile_screen.dart';
import 'package:flowery/features/profile/presentation/view_model/profile_cubit.dart';
import 'package:flowery/features/profile/presentation/view_model/profile_event.dart';
import 'package:flowery/features/profile/presentation/view_model/profile_state.dart';
import 'package:flowery/features/workouts/presentation/view/pages/workouts_page.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileCubit>(
          create: (_) => getIt<ProfileCubit>()..doAction(GetProfileDataEvent()),
        ),
        BlocProvider<AppSectionsCubit>(
          create: (_) => getIt<AppSectionsCubit>(),
        ),
      ],
      child: Scaffold(
        extendBody: true, // Allows background images to extend under the navbar
        body: BlocBuilder<AppSectionsCubit, AppSectionsStates>(
          builder: (context, state) {
            final cubit = context.read<AppSectionsCubit>();
            return PageView(
              controller: cubit.pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                const HomePage(),
                BlocBuilder<ProfileCubit, ProfileStates>(
                  builder: (context, state) {
                    return ChatBotScreen(
                      userId: state.profileState.data?.id ?? "",
                      userFirstName: state.profileState.data?.firstName ?? "",
                      userImage: state.profileState.data?.profileImage ?? "",
                    );
                  },
                ),
                const WorkoutsPage(),
                const ProfileScreen(),
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
