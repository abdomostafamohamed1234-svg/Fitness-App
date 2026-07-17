import 'package:flowery/config/routing/app_routes.dart';
import 'package:flowery/features/register/presentation/view/pages/register_page.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    try {
      switch (settings.name) {
        case AppRoutes.register:
          return MaterialPageRoute(
            builder: (_) => const RegisterPage(),
          );

        // case AppRoutes.login:
        //   return MaterialPageRoute(builder: (_) => const LoginPage());

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
