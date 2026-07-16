import 'dart:ui';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/widgets/glass_container.dart';
import 'package:flowery/features/on_boarding/presentation/assets/on_boarding_assets_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late AppLocalizations localizations;
  late TextTheme textTheme;
  @override
  void didChangeDependencies() {
    localizations = AppLocalizations.of(context)!;
    textTheme = Theme.of(context).textTheme;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: Image.asset(
                OnBoardingAssetsNavigation.background,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Transform.scale(
                  scale: 1.5,
                  child: Image(
                    image: const AssetImage(OnBoardingAssetsNavigation.pose1),
                    width: 375.w,
                    height: 594.h,
                  ),
                ),
                GlassContainer(
                  children: [Text("Title Large", style: textTheme.titleLarge)],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
