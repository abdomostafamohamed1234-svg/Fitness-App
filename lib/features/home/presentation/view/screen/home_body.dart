import 'package:flowery/config/di/di_config.dart';
import 'package:flowery/core/base/base_state.dart';
import 'package:flowery/core/theme/app-assets.dart';

import 'package:flowery/features/home/presentation/view/widgets/category_section_widget.dart';
import 'package:flowery/features/home/presentation/view/widgets/food_section_widget.dart';
import 'package:flowery/features/home/presentation/view/widgets/home_header_widget.dart';
import 'package:flowery/features/home/presentation/view/widgets/home_shimmer_widget.dart';
import 'package:flowery/features/home/presentation/view/widgets/popular_training_widget.dart';
import 'package:flowery/features/home/presentation/view/widgets/recommendation_section_widget.dart';
import 'package:flowery/features/home/presentation/view/widgets/workout_section_widget.dart';
import 'package:flowery/features/home/presentation/view_model/home_cubit.dart';
import 'package:flowery/features/home/presentation/view_model/home_event.dart';
import 'package:flowery/features/home/presentation/view_model/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    // BlocProvider مرة واحدة بره كل حاجة
    return BlocProvider(
      create: (_) => getIt<HomeCubit>()..doAction(GetAllDataEvent()),
      child: Stack(
        children: [
          Image.asset(
            AssetsImage.BackGroundHome,
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: BlocBuilder<HomeCubit, HomeStates>(
              builder: (context, state) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ===== HEADER =====
                        const HomeHeaderWidget(),
                        const SizedBox(height: 16),

                        // ===== CATEGORY (filter chips) =====
                        _buildSection(
                          state: state.workOutState,
                          shimmer: const CategoryShimmer(),
                          loadedBuilder: (data) => CategorySectionWidget(
                            musclesGroup: data.musclesGroup,
                          ),
                        ),
                        const SizedBox(height: 24),

                        // ===== RECOMMENDATION TO DAY =====
                        _buildSection(
                          state: state.recommendationState,
                          shimmer: const RecommendationShimmer(),
                          loadedBuilder: (data) => RecommendationSectionWidget(
                            muscles: data.muscles,
                          ),
                        ),
                        const SizedBox(height: 24),

                        // ===== UPCOMING WORKOUTS (chips + cards) =====
                        const WorkoutSectionWidget(),
                        const SizedBox(height: 24),

                        // _buildSection(
                        //   state: state.workOutState,
                        //   shimmer: const WorkoutShimmer(),
                        //   loadedBuilder: (data) => WorkoutSectionWidget(
                        //     musclesGroup: data.musclesGroup,
                        //   ),
                        // ),
                        // const SizedBox(height: 24),

                        // ===== FOOD / RECOMMENDATION FOR YOU =====
                        _buildSection(
                          state: state.foodState,
                          shimmer: const FoodShimmer(),
                          loadedBuilder: (data) =>
                              FoodSectionWidget(categories: data.categories),
                        ),
                        const SizedBox(height: 24),

                        // ===== POPULAR TRAINING (static) =====
                        const PopularTrainingSectionWidget(),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  //   Widget _buildSection<T>({
  //     required BaseState<T> state,
  //     required Widget shimmer,
  //     required Widget Function(T data) loadedBuilder,
  //   }) {
  //     if (state.isLoading == true) {
  //       return shimmer;
  //     }
  //     if (state.error != null) {
  //       return Center(
  //         child: Text(
  //           state.error.toString(),
  //           style: const TextStyle(color: Colors.red),
  //         ),
  //       );
  //     }
  //     if (state.data != null) {
  //       return loadedBuilder(state.data as T);
  //     }
  //     return const SizedBox.shrink();
  //   }
  // }

  Widget _buildSection<T>({
    required BaseState<T> state,
    required Widget shimmer,
    required Widget Function(T data) loadedBuilder,
  }) {
    return state.when(
      initial: () => const SizedBox.shrink(),
      loading: () => shimmer,
      success: (data) => loadedBuilder(data),
      error: (exception) => Center(
        child: Text(
          exception.toString(),
          style: const TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
