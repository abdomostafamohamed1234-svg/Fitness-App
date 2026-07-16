import 'package:flowery/core/widgets/glass_container.dart';
import 'package:flowery/features/on_boarding/presentation/assets/on_boarding_assets_navigation.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          GlassContainer(
            children: [
              Image(image: AssetImage(OnBoardingAssetsNavigation.background)),
            ],
          ),
        ],
      ),
    );
  }
}
