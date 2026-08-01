// import 'package:flowery/config/di/di_config.dart';
// import 'package:flowery/config/routing/app_routes.dart';
// import 'package:flowery/features/exercises/presentation/arg/exercise_screen_args.dart';
// import 'package:flowery/features/exercises/presentation/screens/exercises_screen.dart';
// import 'package:flowery/features/exercises/presentation/view_model/cubit/exercise_cubit.dart';
// import 'package:flowery/features/exercises/presentation/view_model/events/exercise_events.dart';
// import 'package:flowery/features/forget_password/presentation/screens/forget_password_screen.dart';
// import 'package:flowery/features/forget_password/presentation/view_models/cubit/forget_password_view_model.dart';
// import 'package:flowery/features/auth_with_social_media/presentation/view/widgets/social_register_args.dart';
// import 'package:flowery/features/login/presentation/view/login_screen.dart';
// import 'package:flowery/features/on_boarding/presentation/screens/on_boarding_screen.dart';
// import 'package:flowery/features/on_boarding/presentation/view_model/cubit/on_boarding_cubit.dart';
// import 'package:flowery/features/register/presentation/view/pages/register_page.dart';
// import 'package:flowery/features/food/presentation/screens/food_recommendation_screen.dart';
// import 'package:flowery/features/food/presentation/view_model/cubit/food_cubit.dart';
// import 'package:flowery/features/food/presentation/view_model/events/food_events.dart';
// import 'package:flowery/features/home/presentation/view/screen/home_Page.dart';
// import 'package:flowery/features/workouts/presentation/view/pages/workouts_page.dart';
// import 'package:flowery/features/food/presentation/arg/food_screen_args.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class RouteGenerator {
//   static Route<dynamic> getRoute(RouteSettings settings) {
//     try {
//       switch (settings.name) {
//         case AppRoutes.login:
//           return MaterialPageRoute(builder: (_) => const LoginPage());

//         case AppRoutes.onBoarding:
//           return MaterialPageRoute(
//             builder: (_) => BlocProvider(
//               create: (_) => getIt<OnBoardingCubit>(),
//               child: const OnBoardingScreen(),
//             ),
//           );
//         case AppRoutes.register:
//           return MaterialPageRoute(
//             builder: (context) {
//               final args = settings.arguments;
//               return RegisterPage(
//                 socialArgs: args is SocialRegisterArgs ? args : null,
//               );
//             },
//           );
//         case AppRoutes.home:
//           return MaterialPageRoute(builder: (_) => const HomePage());
//         // case AppRoutes.exercise:

//         // // return MultiBlocProvider(
//         // //   providers: [
//         // //     BlocProvider(
//         // //       create: (_) => getIt<ExerciseCubit>()
//         // //         ..doEvent(
//         // //           LoadExerciseLevelsEvent(muscleId: args.muscleId),
//         // //         ),
//         // //     ),
//         // //   ],
//         // case AppRoutes.food:
//         //   return MaterialPageRoute(
//         //     builder: (context) {
//         //       return MultiBlocProvider(
//         //         providers: [
//         //           BlocProvider(
//         //             create: (_) =>
//         //                 getIt<FoodCubit>()..doEvent(GetMealsCategoriesEvent()),
//         //           ),
//         //         ],
//         //         child: const FoodRecommendationScreen(),
//         //       );
//         //     },
//         //   );
//         case AppRoutes.food:
//           return MaterialPageRoute(
//             builder: (context) {
//               final args = settings.arguments;
//               final categoryName = args is FoodScreenArgs
//                   ? args.categoryName
//                   : null;

//               return MultiBlocProvider(
//                 providers: [
//                   BlocProvider(
//                     create: (_) => getIt<FoodCubit>()
//                       ..doEvent(
//                         GetMealsCategoriesEvent(initialCategory: categoryName),
//                       ),
//                   ),
//                 ],
//                 child: FoodRecommendationScreen(
//                   initialCategoryName: categoryName,
//                 ),
//               );
//             },
//           );
//         case AppRoutes.forgetPassword:
//           return MaterialPageRoute(
//             builder: (_) => BlocProvider(
//               create: (_) => getIt<ForgetPasswordViewModel>(),
//               child: const ForgetPasswordScreen(),
//             ),
//           );

//         case AppRoutes.workouts:
//           return MaterialPageRoute(builder: (_) => const WorkoutsPage());

//         case AppRoutes.exercise:
//           final args = settings.arguments as ExerciseScreenArgs;
//           return MaterialPageRoute(
//             builder: (context) => BlocProvider(
//               create: (_) =>
//                   getIt<ExerciseCubit>()
//                     ..doEvent(LoadExerciseLevelsEvent(muscleId: args.muscleId)),
//               child: ExerciseScreen(
//                 muscleId: args.muscleId,
//                 muscleName: args.muscleName,
//                 backgroundImageUrl: args.backgroundImageUrl,
//                 trainerImageUrl: args.trainerImageUrl,
//               ),
//             ),
//           );
//         default:
//           return unDefinedRoute();
//       }
//     } catch (e) {
//       return errorRoute(e.toString());
//     }
//   }

//   static Route<dynamic> unDefinedRoute() {
//     return MaterialPageRoute(
//       builder: (_) => Scaffold(
//         appBar: AppBar(title: const Text('No Route Found')),
//         body: const Center(child: Text('No Route Found')),
//       ),
//     );
//   }

//   static Route<dynamic> errorRoute(String error) {
//     return MaterialPageRoute(
//       builder: (_) => Scaffold(
//         appBar: AppBar(title: const Text('Route Error')),
//         body: Center(child: Text(error)),
//       ),
//     );
//   }
// }


















import 'package:flowery/config/di/di_config.dart';
import 'package:flowery/config/routing/app_routes.dart';
import 'package:flowery/features/exercises/presentation/arg/exercise_screen_args.dart';
import 'package:flowery/features/exercises/presentation/screens/exercises_screen.dart';
import 'package:flowery/features/exercises/presentation/view_model/cubit/exercise_cubit.dart';
import 'package:flowery/features/exercises/presentation/view_model/events/exercise_events.dart';
import 'package:flowery/features/forget_password/presentation/screens/forget_password_screen.dart';
import 'package:flowery/features/forget_password/presentation/view_models/cubit/forget_password_view_model.dart';
import 'package:flowery/features/auth_with_social_media/presentation/view/widgets/social_register_args.dart';
import 'package:flowery/features/login/presentation/view/login_screen.dart';
import 'package:flowery/features/on_boarding/presentation/screens/on_boarding_screen.dart';
import 'package:flowery/features/on_boarding/presentation/view_model/cubit/on_boarding_cubit.dart';
import 'package:flowery/features/app_sections/presentation/view/pages/app_sections_page.dart';
import 'package:flowery/features/profile/presentation/view/screen/profile_screen.dart';
import 'package:flowery/features/profile/presentation/view_model/profile_cubit.dart';
import 'package:flowery/features/register/presentation/view/pages/register_page.dart';
import 'package:flowery/features/food/presentation/screens/food_recommendation_screen.dart';
import 'package:flowery/features/food/presentation/view_model/cubit/food_cubit.dart';
import 'package:flowery/features/food/presentation/view_model/events/food_events.dart';
import 'package:flowery/features/home/presentation/view/screen/home_Page.dart';
import 'package:flowery/features/workouts/presentation/view/pages/workouts_page.dart';
import 'package:flowery/features/food/presentation/arg/food_screen_args.dart';
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
       
        case AppRoutes.login:
          return MaterialPageRoute(builder: (_) => const LoginPage());

        case AppRoutes.onBoarding:
          return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (_) => getIt<OnBoardingCubit>(),
              child: const OnBoardingScreen(),
            ),
          );
        case AppRoutes.profile:
          return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (_) => getIt<ProfileCubit>(),
              child:  const ProfileScreen(),
            ),
          );

        case AppRoutes.appSections:
          return MaterialPageRoute(
            builder: (_) => const AppSectionsPage(),
          );

        // case AppRoutes.:
        //   return MaterialPageRoute(
        //     builder: (context) {
        //       return MultiBlocProvider(
        //         providers: [
        //           BlocProvider(
        //             create: (_) => 
        //           ),
        //         ],
        //         child: ,
        //       );
        //     },
        //   );
        case AppRoutes.register:
          return MaterialPageRoute(
            builder: (context) {
              final args = settings.arguments;
              return RegisterPage(
                socialArgs: args is SocialRegisterArgs ? args : null,
              );
            },
          );

        case AppRoutes.home:
          return MaterialPageRoute(builder: (_) => const HomePage());

        case AppRoutes.food:
          return MaterialPageRoute(
            builder: (context) {
              final args = settings.arguments;
              final categoryName = args is FoodScreenArgs
                  ? args.categoryName
                  : null;

              return MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (_) => getIt<FoodCubit>()
                      ..doEvent(
                        GetMealsCategoriesEvent(initialCategory: categoryName),
                      ),
                  ),
                ],
                child: FoodRecommendationScreen(
                  initialCategoryName: categoryName,
                ),
              );
            },
          );

        case AppRoutes.forgetPassword:
          return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (_) => getIt<ForgetPasswordViewModel>(),
              child: const ForgetPasswordScreen(),
            ),
          );

        case AppRoutes.workouts:
          return MaterialPageRoute(builder: (_) => const WorkoutsPage());

        case AppRoutes.exercise:
          return MaterialPageRoute(
            builder: (context) {
              final args = settings.arguments;
              if (args is! ExerciseScreenArgs) {
                return errorRouteBody(
                  'Missing or invalid ExerciseScreenArgs for ${AppRoutes.exercise}',
                );
              }
              return BlocProvider(
                create: (_) => getIt<ExerciseCubit>()
                  ..doEvent(LoadExerciseLevelsEvent(muscleId: args.muscleId)),
                child: ExerciseScreen(
                  muscleId: args.muscleId,
                  muscleName: args.muscleName,
                  backgroundImageUrl: args.backgroundImageUrl,
                  trainerImageUrl: args.trainerImageUrl,
                ),
              );
            },
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