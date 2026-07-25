
// import 'package:flowery/features/popular_training/domain/entities/exercise_entity.dart';
// import 'package:flowery/features/popular_training/presentation/view/popular_training%20_card.dart';
// import 'package:flowery/features/popular_training/presentation/view_model/popular_training_cubit.dart';
// import 'package:flowery/features/popular_training/presentation/view_model/popular_training_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';


// class PopularTrainingSection extends StatefulWidget {
//   /// Optional callback: called with the full ExerciseEntity when a card is
//   /// tapped, so a parent screen can navigate to a details screen with it.
//   final void Function(ExerciseEntity exercise)? onExerciseTap;

//   const PopularTrainingSection({super.key, this.onExerciseTap});

//   @override
//   State<PopularTrainingSection> createState() =>
//       _PopularTrainingSectionState();
// }

// class _PopularTrainingSectionState extends State<PopularTrainingSection> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<PopularTrainingCubit>().getPopularTraining();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Padding(
//           padding: EdgeInsets.symmetric(horizontal: 16),
//           child: Text(
//             'Popular Training',
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//         ),
//         const SizedBox(height: 12),
//         SizedBox(
//           height: 210,
//           child: BlocBuilder<PopularTrainingCubit, PopularTrainingState>(
//             builder: (context, state) {
//               return switch (state) {
//                 PopularTrainingInitial() => const SizedBox.shrink(),
//                 PopularTrainingLoading() => const Center(
//                   child: CircularProgressIndicator(),
//                 ),
//                 PopularTrainingSuccess(:final exercises) =>
//                   exercises.isEmpty
//                       ? const Center(
//                           child: Text(
//                             'No Excerises',
//                             style: TextStyle(color: Colors.white70),
//                           ),
//                         )
//                       : ListView.builder(
//                           scrollDirection: Axis.horizontal,
//                           padding: const EdgeInsets.symmetric(horizontal: 16),
//                           itemCount: exercises.length,
//                           itemBuilder: (context, index) {
//                             final exercise = exercises[index];
//                             return PopularTrainingCard(
//                               exercise: exercise,
//                               onTap: () =>
//                                   widget.onExerciseTap?.call(exercise),
//                             );
//                           },
//                         ),
//                 PopularTrainingError(:final exception) => Center(
//                   child: Text(
//                     'حدث خطأ: ${exception.toString()}',
//                     style: const TextStyle(color: Colors.redAccent),
//                   ),
//                 ),
//               };
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }


import 'package:flowery/features/popular_training/domain/entities/exercise_entity.dart';
import 'package:flowery/features/popular_training/presentation/view/popular_training%20_card.dart';
import 'package:flowery/features/popular_training/presentation/view/widget/exercise_details_screen.dart';
import 'package:flowery/features/popular_training/presentation/view_model/popular_training_cubit.dart';
import 'package:flowery/features/popular_training/presentation/view_model/popular_training_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularTrainingSection extends StatefulWidget {
  /// Optional: called instead of the default navigation when a card is
  /// tapped. Leave it null to just push [ExerciseDetailsScreen] with the
  /// tapped exercise (the normal case).
  final void Function(ExerciseEntity exercise)? onExerciseTap;

  const PopularTrainingSection({super.key, this.onExerciseTap});

  @override
  State<PopularTrainingSection> createState() =>
      _PopularTrainingSectionState();
}

class _PopularTrainingSectionState extends State<PopularTrainingSection> {
  @override
  void initState() {
    super.initState();
    context.read<PopularTrainingCubit>().getPopularTraining();
  }

  void _handleExerciseTap(ExerciseEntity exercise) {
    if (widget.onExerciseTap != null) {
      widget.onExerciseTap!(exercise);
      return;
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ExerciseDetailsScreen(exercise: exercise),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Popular Training',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 210,
          child: BlocBuilder<PopularTrainingCubit, PopularTrainingState>(
            builder: (context, state) {
              return switch (state) {
                PopularTrainingInitial() => const SizedBox.shrink(),
                PopularTrainingLoading() => const Center(
                  child: CircularProgressIndicator(),
                ),
                PopularTrainingSuccess(:final exercises) =>
                  exercises.isEmpty
                      ? const Center(
                          child: Text(
                            'No Excerises',
                            style: TextStyle(color: Colors.white70),
                          ),
                        )
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: exercises.length,
                          itemBuilder: (context, index) {
                            final exercise = exercises[index];
                            return PopularTrainingCard(
                              exercise: exercise,
                              onTap: () => _handleExerciseTap(exercise),
                            );
                          },
                        ),
                PopularTrainingError(:final exception) => Center(
                  child: Text(
                    'حدث خطأ: ${exception.toString()}',
                    style: const TextStyle(color: Colors.redAccent),
                  ),
                ),
              };
            },
          ),
        ),
      ],
    );
  }
}