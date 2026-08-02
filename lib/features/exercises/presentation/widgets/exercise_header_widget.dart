import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/features/exercises/domain/entities/levels_entity.dart';
import 'package:flowery/features/exercises/presentation/view_model/base_state/exercise_state.dart';
import 'package:flowery/features/exercises/presentation/view_model/cubit/exercise_cubit.dart';
import 'package:flowery/features/exercises/presentation/widgets/level_selector_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExerciseHeaderWidget extends StatelessWidget {
  final String muscleName;
  final String? trainerImageUrl;

  const ExerciseHeaderWidget({
    super.key,
    required this.muscleName,
    this.trainerImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            InkWell(
              onTap: () => Navigator.of(context).maybePop(),
              borderRadius: BorderRadius.circular(30),
              child: const CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.primaryColor,
                child: Icon(Icons.chevron_left, color: AppColors.whiteColor),
              ),
            ),
          ],
        ),
        const SizedBox(height: 60),
        Text(
          "$muscleName ${localization.exercise}",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: 8),
        Text(
          localization.follow_the_plan,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            const _InfoChip(label: "30 MIN"),
            const Spacer(),
            if (trainerImageUrl != null)
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(trainerImageUrl!),
              ),
            const SizedBox(width: 10),
            const _InfoChip(label: "130 Cal", filled: true),
          ],
        ),
        const SizedBox(height: 18),
      ],
    );
  }
}

class _InfoChip extends StatelessWidget {
  final String label;
  final bool filled;

  const _InfoChip({required this.label, this.filled = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: filled ? AppColors.primaryColor.withValues(alpha: .15) : null,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: filled
              ? AppColors.primaryColor
              : AppColors.whiteColor.withValues(alpha: .4),
        ),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          color: filled ? AppColors.primaryColor : AppColors.whiteColor,
          fontSize: 12,
        ),
      ),
    );
  }
}

class ExerciseLevelsBar extends StatelessWidget {
  const ExerciseLevelsBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExerciseCubit, ExerciseState>(
      buildWhen: (previous, current) =>
          previous.levelsState != current.levelsState ||
          previous.selectedLevelId != current.selectedLevelId,
      builder: (context, state) {
        return state.levelsState.when(
          initial: () => const SizedBox.shrink(),
          loading: () => const SizedBox(
            height: 44,
            child: Center(
              child: SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ),
          success: (LevelsEntity data) => LevelSelectorWidget(
            levels: data.difficultyLevels ?? const [],
            selectedLevelId: state.selectedLevelId,
          ),
          error: (exception) => const SizedBox.shrink(),
        );
      },
    );
  }
}
