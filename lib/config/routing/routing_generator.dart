import 'package:flowery/config/di/di_config.dart';
import 'package:flowery/config/routing/app_routes.dart';

import 'package:flowery/features/home/presentation/view/screen/home_Page.dart';

import 'package:flowery/features/forget_password/presentation/screens/forget_password_screen.dart';
import 'package:flowery/features/forget_password/presentation/view_models/cubit/forget_password_view_model.dart';
import 'package:flowery/features/change_password/presentation/screens/change_password_screen.dart';
import 'package:flowery/features/change_password/presentation/view_model/change_password_view_model.dart';
import 'package:flowery/features/on_boarding/presentation/screens/on_boarding_screen.dart';
import 'package:flowery/features/on_boarding/presentation/view_model/cubit/on_boarding_cubit.dart';
import 'package:flowery/features/app_sections/presentation/view/pages/app_sections_page.dart';
import 'package:flowery/features/food/presentation/screens/food_recommendation_screen.dart';
import 'package:flowery/features/food/presentation/view_model/cubit/food_cubit.dart';
import 'package:flowery/features/food/presentation/view_model/events/food_events.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    try {
      switch (settings.name) {
        // case AppRoutes.login:
        //   return MaterialPageRoute(builder: (_) => const LoginPage());


        // case AppRoutes.register:
        //   return MaterialPageRoute(
        //     builder: (context) {
        //       final args = settings.arguments;
        //       return RegisterPage(
        //         socialArgs: args is SocialRegisterArgs ? args : null,
        //       );
        //     },
        //   );

        case AppRoutes.home:
          return MaterialPageRoute(builder: (_) => const HomePage());


        // case AppRoutes.workouts:
        //   return MaterialPageRoute(builder: (_) => const WorkoutsPage());

        // case AppRoutes.exercise:
        //   return MaterialPageRoute(
        //     builder: (context) {
        //       final args = settings.arguments;
        //       if (args is! ExerciseScreenArgs) {
        //         return errorRouteBody(
        //           'Missing or invalid ExerciseScreenArgs for ${AppRoutes.exercise}',
        //         );
        //       }
        //       return BlocProvider(
        //         create: (_) => getIt<ExerciseCubit>()
        //           ..doEvent(LoadExerciseLevelsEvent(muscleId: args.muscleId)),
          
          
          
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

       
        case AppRoutes.onBoarding:
          return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (_) => getIt<OnBoardingCubit>(),
              child: const OnBoardingScreen(),
            ),
          );

        case AppRoutes.appSections:
          return MaterialPageRoute(
            builder: (_) => const AppSectionsPage(),
          );



        case AppRoutes.food:
          return MaterialPageRoute(
            builder: (context) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (_) =>
                        getIt<FoodCubit>()..doEvent(GetMealsCategoriesEvent()),
                  ),
                ],
                child: const FoodRecommendationScreen(),
              );
            },
          );

        case AppRoutes.forgetPassword:
          return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (_) => getIt<ForgetPasswordViewModel>(),
              child: const ForgetPasswordScreen()));
        case AppRoutes.changePassword:
          return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (_) => getIt<ChangePasswordViewModel>(),
              child: const ChangePasswordScreen(),
            ),
          );
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

  static Widget errorRouteBody(String error) {
    return Scaffold(
      appBar: AppBar(title: const Text('Route Error')),
      body: Center(child: Text(error)),
    );
  }
}