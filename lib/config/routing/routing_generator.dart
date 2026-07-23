import 'package:flowery/config/di/di_config.dart';
import 'package:flowery/config/routing/app_routes.dart';
import 'package:flowery/features/exercises/presentation/screens/exercises_screen.dart';
import 'package:flowery/features/exercises/presentation/view_model/cubit/exercise_cubit.dart';
import 'package:flowery/features/exercises/presentation/view_model/events/exercise_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    try {
      switch (settings.name) {
        //  case AppRoutes.exercise:
        //   return MaterialPageRoute(
        //     builder: (context) {
        //       final args = settings.arguments;
        //       if (args is! ExerciseScreenArgs) {
        //         return Scaffold(
        //           appBar: AppBar(title: const Text('Route Error')),
        //           body: const Center(
        //             child: Text("ExerciseScreenArgs is missing or invalid"),
        //           ),
        //         );
        //       }
 
        //       return MultiBlocProvider(
        //         providers: [
        //           BlocProvider(
        //             create: (_) => getIt<ExerciseCubit>()
        //               ..doEvent(
        //                 LoadExerciseLevelsEvent(muscleId: args.muscleId),
        //               ),
        //           ),
        //         ],
        //         child: ExerciseScreen(
        //           muscleId: args.muscleId,
        //           muscleName: args.muscleName,
        //           backgroundImageUrl: args.backgroundImageUrl,
        //           trainerImageUrl: args.trainerImageUrl,
        //         ),
        //       );
        //     },
        //   );
        default:
          return unDefinedRoute();
      }
    } catch (e) {
      return errorRoute(e.toString());
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('No Route Found')),
        body: const Center(child: Text('No Route Found')),
      ),
    );
  }

  static Route<dynamic> errorRoute(String error) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Route Error')),
        body: Center(child: Text(error)),
      ),
    );
  }
}
