import 'package:flowery/features/workouts/presentation/view_model/cubit/workouts_cubit.dart';
import 'package:flowery/features/workouts/presentation/view_model/cubit/workouts_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import 'workout_item.dart';

class WorkoutsGridSection extends StatelessWidget {
  const WorkoutsGridSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<WorkoutsCubit, WorkoutsState>(
        buildWhen: (previous, current) =>
            previous.workoutsState != current.workoutsState,
        builder: (context, state) {
          return state.workoutsState.when(
            initial: () => const SizedBox.shrink(),
            loading: () => _buildShimmer(),
            success: (data) {
              final muscles = data.muscles ?? [];
              if (muscles.isEmpty) {
                return const Center(
                  child: Text(
                    'No workouts found',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }
              return GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.w,
                  mainAxisSpacing: 16.h,
                  childAspectRatio: 0.9,
                ),
                itemCount: muscles.length,
                itemBuilder: (context, index) {
                  final muscle = muscles[index];
                  return WorkoutItem(
                    name: muscle.name ?? "",
                    image: muscle.image,
                  );
                },
              );
            },
            error: (exception) => Center(
              child: Text(
                exception.toString(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[800]!,
      highlightColor: Colors.grey[600]!,
      child: GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.w,
          mainAxisSpacing: 16.h,
          childAspectRatio: 0.9,
        ),
        itemCount: 4,
        itemBuilder: (context, index) => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
      ),
    );
  }
}