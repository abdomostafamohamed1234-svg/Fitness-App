import 'package:flowery/config/routing/app_routes.dart';
import 'package:flowery/config/routing/routing_extensions.dart';
import 'package:flutter/material.dart';

class SkipButton extends StatelessWidget {
  final String skip;
  const SkipButton({super.key, required this.skip});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () {
              context.pushNamed(AppRoutes.login);
            },
            child: Text(skip),
          ),
        ],
      ),
    );
  }
}
