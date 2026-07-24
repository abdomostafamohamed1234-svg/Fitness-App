// import 'package:flowery/core/theme/app_colors.dart';
// import 'package:flowery/features/home/domian/entities/work_out_model.dart';
// import 'package:flutter/material.dart';

// class WorkoutSectionWidget extends StatefulWidget {
//   final List<MuscleGroupModel> musclesGroup;

//   const WorkoutSectionWidget({super.key, required this.musclesGroup});

//   @override
//   State<WorkoutSectionWidget> createState() => _WorkoutSectionWidgetState();
// }

// class _WorkoutSectionWidgetState extends State<WorkoutSectionWidget> {
//   int _selectedIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     final selected = widget.musclesGroup.isNotEmpty
//         ? widget.musclesGroup[_selectedIndex]
//         : null;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Title + See All
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Text(
//               'Upcoming Workouts',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             TextButton(
//               onPressed: () {
//                // Navigator.pushNamed(context, Routes.workouts);
//               },
//               child: const Text(
//                 'See All',
//                 style: TextStyle(
//                   color: AppColors.primaryColor,
//                   fontSize: 14,
//                   decoration: TextDecoration.underline,
//                   decorationColor: AppColors.primaryColor,
//                   decorationThickness: 2,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 12),

//         // Filter chips (horizontal scroll)
//         SizedBox(
//           height: 36,
//           child: ListView.separated(
//             scrollDirection: Axis.horizontal,
//             itemCount: widget.musclesGroup.length,
//             separatorBuilder: (_, _) => const SizedBox(width: 8),
//             itemBuilder: (context, index) {
//               final isSelected = index == _selectedIndex;
//               return GestureDetector(
//                 onTap: () => setState(() => _selectedIndex = index),
//                 child: AnimatedContainer(
//                   duration: const Duration(milliseconds: 200),
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 16,
//                     vertical: 6,
//                   ),
//                   decoration: BoxDecoration(
//                     color: isSelected
//                         ? AppColors.primaryColor
//                         : Colors.grey[850],
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Text(
//                     widget.musclesGroup[index].name,
//                     style: TextStyle(
//                       color: isSelected ? Colors.white : Colors.white70,
//                       fontSize: 13,
//                       fontWeight: isSelected
//                           ? FontWeight.bold
//                           : FontWeight.normal,
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//         const SizedBox(height: 14),

//         // Workout cards (horizontal scroll)
//         SizedBox(
//           height: 130,
//           child: ListView.separated(
//             scrollDirection: Axis.horizontal,
//             itemCount: 4, // static placeholders
//             separatorBuilder: (_, _) => const SizedBox(width: 12),
//             itemBuilder: (context, index) {
//               return _WorkoutCard(name: selected?.name ?? '', index: index);
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _WorkoutCard extends StatelessWidget {
//   final String name;
//   final int index;

//   const _WorkoutCard({required this.name, required this.index});

//   static const List<String> _placeholderImages = [
//     'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?w=400',
//     'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=400',
//     'https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?w=400',
//     'https://images.unsplash.com/photo-1549060279-7e168fcee0c2?w=400',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(16),
//       child: Stack(
//         children: [
//           // Image
//           SizedBox(
//             width: 120,
//             height: 130,
//             child: Image.network(
//               _placeholderImages[index % _placeholderImages.length],
//               fit: BoxFit.cover,
//               errorBuilder: (_, _, _) => Container(
//                 color: Colors.grey[850],
//                 child: const Icon(
//                   Icons.fitness_center,
//                   color: Colors.orange,
//                   size: 32,
//                 ),
//               ),
//             ),
//           ),
//           // Overlay
//           Container(
//             width: 120,
//             height: 130,
//             color: Colors.black.withValues(alpha: 0.4),
//           ),
//           // Label
//           Positioned(
//             bottom: 10,
//             left: 8,
//             right: 8,
//             child: Text(
//               name.isNotEmpty ? name : 'Workout',
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.w600,
//                 fontSize: 12,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flowery/config/di/di_config.dart';
// import 'package:flowery/core/theme/app_colors.dart';
// import 'package:flowery/features/workouts/presentation/view_model/cubit/workouts_cubit.dart';
// import 'package:flowery/features/workouts/presentation/view_model/cubit/workouts_event.dart';
// import 'package:flowery/features/workouts/presentation/view_model/cubit/workouts_states.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class WorkoutSectionWidget extends StatelessWidget {
//   const WorkoutSectionWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) =>
//           getIt<WorkoutsCubit>()..doEvent(GetMuscleGroupsIntent()),
//       child: const _WorkoutSectionBody(),
//     );
//   }
// }

// class _WorkoutSectionBody extends StatelessWidget {
//   const _WorkoutSectionBody();

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<WorkoutsCubit, WorkoutsState>(
//       builder: (context, state) {
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // ===== Title + See All =====
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   'Upcoming Workouts',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 TextButton(
//                   onPressed: () =>
//                       Navigator.pushNamed(context, Routes.workouts),
//                   child: const Text(
//                     'See All',
//                     style: TextStyle(
//                       color: AppColors.primaryColor,
//                       fontSize: 14,
//                       decoration: TextDecoration.underline,
//                       decorationColor: AppColors.primaryColor,
//                       decorationThickness: 2,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 12),

//             // ===== Muscle Group Filter Chips =====
//             _buildMuscleGroupChips(context, state),
//             const SizedBox(height: 14),

//             // ===== Workout Cards =====
//             _buildWorkoutCards(state),
//           ],
//         );
//       },
//     );
//   }

//   Widget _buildMuscleGroupChips(BuildContext context, WorkoutsState state) {
//     final muscleGroupsState = state.muscleGroupsState;

//     if (muscleGroupsState.isLoading == true) {
//       return _ChipsShimmer();
//     }

//     if (muscleGroupsState.error != null) {
//       return Text(
//         muscleGroupsState.error.toString(),
//         style: const TextStyle(color: Colors.red, fontSize: 12),
//       );
//     }

//     final groups = muscleGroupsState.data;
//     if (groups == null || groups.isEmpty) return const SizedBox.shrink();

//     return SizedBox(
//       height: 36,
//       child: ListView.separated(
//         scrollDirection: Axis.horizontal,
//         itemCount: groups.length,
//         separatorBuilder: (_, __) => const SizedBox(width: 8),
//         itemBuilder: (context, index) {
//           final group = groups[index];
//           final isSelected = group.id == state.selectedGroupId;

//           return GestureDetector(
//             onTap: () {
//               if (!isSelected && group.id != null) {
//                 context
//                     .read<WorkoutsCubit>()
//                     .doEvent(GetWorkoutsByGroupIntent(group.id!));
//               }
//             },
//             child: AnimatedContainer(
//               duration: const Duration(milliseconds: 200),
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
//               decoration: BoxDecoration(
//                 color:
//                     isSelected ? AppColors.primaryColor : Colors.grey[850],
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Text(
//                 group.name ?? '',
//                 style: TextStyle(
//                   color: isSelected ? Colors.white : Colors.white70,
//                   fontSize: 13,
//                   fontWeight:
//                       isSelected ? FontWeight.bold : FontWeight.normal,
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildWorkoutCards(WorkoutsState state) {
//     final workoutsState = state.workoutsState;

//     if (workoutsState.isLoading == true) {
//       return _WorkoutCardsShimmer();
//     }

//     if (workoutsState.error != null) {
//       return Center(
//         child: Text(
//           workoutsState.error.toString(),
//           style: const TextStyle(color: Colors.red),
//         ),
//       );
//     }

//     final muscleGroupData = workoutsState.data;
//     final muscles = muscleGroupData?.muscles ?? [];

//     if (muscles.isEmpty) return const SizedBox.shrink();

//     return SizedBox(
//       height: 130,
//       child: ListView.separated(
//         scrollDirection: Axis.horizontal,
//         itemCount: muscles.length,
//         separatorBuilder: (_, __) => const SizedBox(width: 12),
//         itemBuilder: (context, index) {
//           final muscle = muscles[index];
//           return _WorkoutCard(
//             name: muscle.name ?? '',
//             imageUrl: muscle.image,
//           );
//         },
//       ),
//     );
//   }
// }

// // ===== Workout Card =====
// class _WorkoutCard extends StatelessWidget {
//   final String name;
//   final String? imageUrl;

//   const _WorkoutCard({required this.name, this.imageUrl});

//   static const List<String> _placeholderImages = [
//     'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?w=400',
//     'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=400',
//     'https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?w=400',
//     'https://images.unsplash.com/photo-1549060279-7e168fcee0c2?w=400',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final displayImage = (imageUrl != null && imageUrl!.isNotEmpty)
//         ? imageUrl!
//         : _placeholderImages[name.hashCode.abs() % _placeholderImages.length];

//     return ClipRRect(
//       borderRadius: BorderRadius.circular(16),
//       child: Stack(
//         children: [
//           // Image
//           SizedBox(
//             width: 120,
//             height: 130,
//             child: Image.network(
//               displayImage,
//               fit: BoxFit.cover,
//               errorBuilder: (_, __, ___) => Container(
//                 color: Colors.grey[850],
//                 child: const Icon(
//                   Icons.fitness_center,
//                   color: Colors.orange,
//                   size: 32,
//                 ),
//               ),
//             ),
//           ),
//           // Dark overlay
//           Container(
//             width: 120,
//             height: 130,
//             color: Colors.black.withValues(alpha: 0.4),
//           ),
//           // Label
//           Positioned(
//             bottom: 10,
//             left: 8,
//             right: 8,
//             child: Text(
//               name.isNotEmpty ? name : 'Workout',
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.w600,
//                 fontSize: 12,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ===== Shimmer Placeholders =====
// class _ChipsShimmer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 36,
//       child: ListView.separated(
//         scrollDirection: Axis.horizontal,
//         itemCount: 5,
//         separatorBuilder: (_, __) => const SizedBox(width: 8),
//         itemBuilder: (_, __) => Container(
//           width: 72,
//           height: 36,
//           decoration: BoxDecoration(
//             color: Colors.grey[800],
//             borderRadius: BorderRadius.circular(20),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _WorkoutCardsShimmer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 130,
//       child: ListView.separated(
//         scrollDirection: Axis.horizontal,
//         itemCount: 4,
//         separatorBuilder: (_, __) => const SizedBox(width: 12),
//         itemBuilder: (_, __) => Container(
//           width: 120,
//           height: 130,
//           decoration: BoxDecoration(
//             color: Colors.grey[800],
//             borderRadius: BorderRadius.circular(16),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flowery/config/di/di_config.dart';
import 'package:flowery/config/routing/app_routes.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/features/workouts/presentation/view_model/cubit/workouts_cubit.dart';
import 'package:flowery/features/workouts/presentation/view_model/cubit/workouts_event.dart';
import 'package:flowery/features/workouts/presentation/view_model/cubit/workouts_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkoutSectionWidget extends StatelessWidget {
  const WorkoutSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<WorkoutsCubit>()..doEvent(GetMuscleGroupsIntent()),
      child: const _WorkoutSectionBody(),
    );
  }
}

class _WorkoutSectionBody extends StatelessWidget {
  const _WorkoutSectionBody();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkoutsCubit, WorkoutsState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== Title + See All =====
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Upcoming Workouts',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.workouts);
                  },
                  // onPressed: () =>
                  //     Navigator.pushNamed(context, Routes.workouts),
                  child: const Text(
                    'See All',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.primaryColor,
                      decorationThickness: 2,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // ===== Muscle Group Filter Chips =====
            _buildMuscleGroupChips(context, state),
            const SizedBox(height: 14),

            // ===== Workout Cards =====
            _buildWorkoutCards(state),
          ],
        );
      },
    );
  }

  Widget _buildMuscleGroupChips(BuildContext context, WorkoutsState state) {
    return state.muscleGroupsState.when(
      initial: () => const SizedBox.shrink(),
      loading: () => _ChipsShimmer(),
      error: (exception) => Text(
        exception.toString(),
        style: const TextStyle(color: Colors.red, fontSize: 12),
      ),
      success: (groups) {
        if (groups.isEmpty) return const SizedBox.shrink();

        return SizedBox(
          height: 36,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: groups.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final group = groups[index];
              final isSelected = group.id == state.selectedGroupId;

              return GestureDetector(
                onTap: () {
                  if (!isSelected && group.id != null) {
                    context.read<WorkoutsCubit>().doEvent(
                      GetWorkoutsByGroupIntent(group.id!),
                    );
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primaryColor
                        : Colors.grey[850],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    group.name ?? '',
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.white70,
                      fontSize: 13,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildWorkoutCards(WorkoutsState state) {
    return state.workoutsState.when(
      initial: () => const SizedBox.shrink(),
      loading: () => _WorkoutCardsShimmer(),
      error: (exception) => Center(
        child: Text(
          exception.toString(),
          style: const TextStyle(color: Colors.red),
        ),
      ),
      success: (muscleGroupData) {
        final muscles = muscleGroupData.muscles ?? [];

        if (muscles.isEmpty) return const SizedBox.shrink();

        return SizedBox(
          height: 130,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: muscles.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final muscle = muscles[index];
              return _WorkoutCard(
                name: muscle.name ?? '',
                imageUrl: muscle.image,
              );
            },
          ),
        );
      },
    );
  }
}

// ===== Workout Card =====
class _WorkoutCard extends StatelessWidget {
  final String name;
  final String? imageUrl;

  const _WorkoutCard({required this.name, this.imageUrl});

  static const List<String> _placeholderImages = [
    'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?w=400',
    'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=400',
    'https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?w=400',
    'https://images.unsplash.com/photo-1549060279-7e168fcee0c2?w=400',
  ];

  @override
  Widget build(BuildContext context) {
    final displayImage = (imageUrl != null && imageUrl!.isNotEmpty)
        ? imageUrl!
        : _placeholderImages[name.hashCode.abs() % _placeholderImages.length];

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        children: [
          // Image
          SizedBox(
            width: 120,
            height: 130,
            child: Image.network(
              displayImage,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: Colors.grey[850],
                child: const Icon(
                  Icons.fitness_center,
                  color: Colors.orange,
                  size: 32,
                ),
              ),
            ),
          ),
          // Dark overlay
          Container(
            width: 120,
            height: 130,
            color: Colors.black.withValues(alpha: 0.4),
          ),
          // Label
          Positioned(
            bottom: 10,
            left: 8,
            right: 8,
            child: Text(
              name.isNotEmpty ? name : 'Workout',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ===== Shimmer Placeholders =====
class _ChipsShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, __) => Container(
          width: 72,
          height: 36,
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}

class _WorkoutCardsShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, __) => Container(
          width: 120,
          height: 130,
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
