import 'package:flowery/config/routing/app_routes.dart';
import 'package:flowery/features/app_sections/presentation/view/pages/app_sections_page.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    try {
      switch (settings.name) {

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
