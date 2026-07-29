import 'dart:ui';
import 'package:flowery/features/on_boarding/presentation/assets/on_boarding_assets_navigation.dart';
import 'package:flutter/material.dart';

class BlurredBackgroundImage extends StatelessWidget {
  const BlurredBackgroundImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Image.asset(
          OnBoardingAssetsNavigation.background,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
