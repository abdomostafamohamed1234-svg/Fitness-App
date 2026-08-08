import 'package:flowery/features/workouts/presentation/view_model/cubit/workouts_cubit.dart';
import 'package:flowery/features/workouts/presentation/view_model/cubit/workouts_event.dart';
import 'package:flowery/features/workouts/presentation/view_model/cubit/workouts_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import 'category_item.dart';

class CategoriesListSection extends StatelessWidget {
  const CategoriesListSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: BlocBuilder<WorkoutsCubit, WorkoutsState>(
        buildWhen: (previous, current) =>
            previous.muscleGroupsState != current.muscleGroupsState ||
            previous.selectedGroupId != current.selectedGroupId,
        builder: (context, state) {
          return state.muscleGroupsState.when(
            initial: () => const SizedBox.shrink(),
            loading: () => _buildShimmer(),
            success: (groups) {
              if (groups.isEmpty) {
                return const Center(
                  child: Text(
                    'No categories found',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }
              return ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                scrollDirection: Axis.horizontal,
                itemCount: groups.length,
                separatorBuilder: (context, index) => SizedBox(width: 1.w),
                itemBuilder: (context, index) {
                  final group = groups[index];
                  return CategoryItem(
                    name: group.name ?? "",
                    isSelected: state.selectedGroupId == group.id,
                    onTap: () {
                      context.read<WorkoutsCubit>().doEvent(
                        GetWorkoutsByGroupIntent(group.id ?? ""),
                      );
                    },
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
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        separatorBuilder: (context, index) => SizedBox(width: 12.w),
        itemBuilder: (context, index) => Container(
          width: 100.w,
          height: 40.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
          ),
        ),
      ),
    );
  }
}