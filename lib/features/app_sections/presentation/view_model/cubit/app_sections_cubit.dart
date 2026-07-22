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