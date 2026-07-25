import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/features/exercises/domain/entities/exercises_entity.dart';
import 'package:flowery/features/exercises/presentation/assets/assets_url.dart';
import 'package:flowery/features/exercises/presentation/view_model/base_state/exercise_state.dart';
import 'package:flowery/features/exercises/presentation/view_model/cubit/exercise_cubit.dart';
import 'package:flowery/features/exercises/presentation/widgets/exercise_header_widget.dart';
import 'package:flowery/features/exercises/presentation/widgets/exercise_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExerciseScreen extends StatelessWidget {
  final String muscleId;
  final String muscleName;
  final String? backgroundImageUrl;
  final String? trainerImageUrl;

  const ExerciseScreen({
    super.key,
    required this.muscleId,
    required this.muscleName,
    this.backgroundImageUrl,
    this.trainerImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image(
              image: backgroundImageUrl != null
                  ? NetworkImage(backgroundImageUrl!) as ImageProvider
                  : const AssetImage(AssetsUrl.backgroundImage),
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(color: Colors.black.withValues(alpha: .55)),
          ),
          SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                  sliver: SliverToBoxAdapter(
                    child: ExerciseHeaderWidget(
                      muscleName: muscleName,
                      trainerImageUrl: trainerImageUrl,
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: ExerciseLevelsBar()),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
                  sliver: BlocBuilder<ExerciseCubit, ExerciseState>(
                    buildWhen: (previous, current) =>
                        previous.exercisesState != current.exercisesState,
                    builder: (context, state) {
                      return state.exercisesState.when(
                        initial: () =>
                            const SliverToBoxAdapter(child: SizedBox.shrink()),
                        loading: () => const SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 40),
                            child: Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ),
                        success: (ExercisesEntity data) {
                          final exercises = data.exercises ?? const [];
                          if (exercises.isEmpty) {
                            return SliverToBoxAdapter(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 40,
                                ),
                                child: Center(
                                  child: Text(
                                    localization.no_exercises_found,
                                    style: const TextStyle(
                                      color: AppColors.greyColor,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                          return SliverList.builder(
                            itemCount: exercises.length,
                            itemBuilder: (context, index) {
                              return ExerciseItemCard(
                                exercise: exercises[index],
                              );
                            },
                          );
                        },
                        error: (exception) => SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 40),
                            child: Center(
                              child: Text(
                                exception.toString(),
                                style: const TextStyle(
                                  color: AppColors.errorColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
