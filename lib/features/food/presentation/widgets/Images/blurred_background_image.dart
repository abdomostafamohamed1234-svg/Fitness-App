import 'dart:ui';
import 'package:flutter/material.dart';

class BlurredBackgroundImage extends StatelessWidget {
  final String image;
  final double blurStrength;
  const BlurredBackgroundImage({
    super.key,
    required this.image,
    required this.blurStrength,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: blurStrength, sigmaY: blurStrength),
        child: Image.asset(image, fit: BoxFit.cover),
      ),
    );
  }
}
