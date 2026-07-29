import 'package:flowery/config/di/di_config.dart';
import 'package:flowery/config/routing/app_routes.dart';
import 'package:flowery/features/home/presentation/view/screen/home_Page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    try {
      switch (settings.name) {
        // case AppRoutes.login:
        //   return MaterialPageRoute(builder: (_) => const LoginPage());

        // case AppRoutes.onBoarding:
        //   return MaterialPageRoute(
        //     builder: (_) => BlocProvider(
        //       create: (_) => getIt<OnBoardingCubit>(),
        //       child: const OnBoardingScreen(),
        //     ),
        //   );

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

        // case AppRoutes.food:
        //   return MaterialPageRoute(
        //     builder: (context) {
        //       final args = settings.arguments;
        //       final categoryName = args is FoodScreenArgs
        //           ? args.categoryName
        //           : null;

        //       return MultiBlocProvider(
        //         providers: [
        //           BlocProvider(
        //             create: (_) => getIt<FoodCubit>()
        //               ..doEvent(
        //                 GetMealsCategoriesEvent(initialCategory: categoryName),
        //               ),
        //           ),
        //         ],
        //         child: FoodRecommendationScreen(
        //           initialCategoryName: categoryName,
        //         ),
        //       );
        //     },
        //   );

        // case AppRoutes.forgetPassword:
        //   return MaterialPageRoute(
        //     builder: (_) => BlocProvider(
        //       create: (_) => getIt<ForgetPasswordViewModel>(),
        //       child: const ForgetPasswordScreen(),
        //     ),
        //   );

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

  static Widget errorRouteBody(String error) {
    return Scaffold(
      appBar: AppBar(title: const Text('Route Error')),
      body: Center(child: Text(error)),
    );
  }
}