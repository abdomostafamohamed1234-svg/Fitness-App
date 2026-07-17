
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/theme/app_assets.dart';
import 'package:flowery/features/app_sections/domain/entities/custom_nav_item_model.dart';
import 'package:flowery/features/app_sections/presentation/view_model/cubit/app_sections_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class AppSectionsCubit extends Cubit<AppSectionsStates> {
  AppSectionsCubit()
    : pageController = PageController(initialPage: 0),
      super(const AppSectionsStates(currentIndex: 0));
  final PageController pageController;

  final items = [
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

  void setCurrentIndex(int index) {
    emit(state.copyWith(currentIndex: index));
    if (pageController.hasClients) {
      pageController.jumpToPage(index);
    }
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
