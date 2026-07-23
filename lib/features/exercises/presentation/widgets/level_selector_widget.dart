import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/features/exercises/domain/entities/levels_entity.dart';
import 'package:flowery/features/exercises/presentation/view_model/cubit/exercise_cubit.dart';
import 'package:flowery/features/exercises/presentation/view_model/events/exercise_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LevelSelectorWidget extends StatelessWidget {
  final List<DifficultyLevelEntity> levels;
  final String selectedLevelId;

  const LevelSelectorWidget({
    super.key,
    required this.levels,
    required this.selectedLevelId,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: levels.map((level) {
          final isSelected = level.id == selectedLevelId;
          return Padding(
            padding: const EdgeInsets.only(left: 10),
            child: GestureDetector(
              onTap: () {
                if (level.id == null || isSelected) return;
                context.read<ExerciseCubit>().doEvent(
                  SelectDifficultyLevelEvent(
                    oldLevelId: selectedLevelId,
                    newLevelId: level.id!,
                  ),
                );
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primaryColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primaryColor
                        : AppColors.whiteColor.withValues(alpha: .4),
                  ),
                ),
                child: Text(
                  level.name ?? "",
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(color: AppColors.whiteColor),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
