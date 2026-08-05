import 'package:flowery/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ChangePasswordBackground extends StatelessWidget {
  final Widget child;

  const ChangePasswordBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset('assets/on_boarding_background.jpg', fit: BoxFit.cover),
        Container(color: AppColors.transparent),
        child,
      ],
    );
  }
}
