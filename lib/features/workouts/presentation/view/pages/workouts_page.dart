import 'package:flowery/config/di/di_config.dart';
import 'package:flowery/features/workouts/presentation/view/widgets/workouts_body.dart';
import 'package:flowery/features/workouts/presentation/view_model/cubit/workouts_cubit.dart';
import 'package:flowery/features/workouts/presentation/view_model/cubit/workouts_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkoutsPage extends StatelessWidget {
  const WorkoutsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<WorkoutsCubit>()..doEvent(GetMuscleGroupsIntent()),
      child: const Scaffold(
        backgroundColor: Colors.black, 
        body: WorkoutsBody(),
      ),
    );
  }
}
