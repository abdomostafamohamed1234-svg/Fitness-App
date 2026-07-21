import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/features/on_boarding/presentation/view_model/cubit/on_boarding_cubit.dart';
import 'package:flowery/features/on_boarding/presentation/view_model/state/on_boarding_state.dart';
import 'package:flowery/features/on_boarding/presentation/widgets/blurred_background_image.dart';
import 'package:flowery/features/on_boarding/presentation/widgets/blurred_container.dart';
import 'package:flowery/features/on_boarding/presentation/widgets/pose_image.dart';
import 'package:flowery/features/on_boarding/presentation/widgets/skip_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late AppLocalizations localizations;
  late TextTheme textTheme;
  final PageController controller = PageController();
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
        alignment: Alignment.topRight,
        children: [
          // Background blur image
          const BlurredBackgroundImage(),

          // Pose Image & Blurred Container
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              // Pose Image
              PoseImage(controller: controller),

              // Container
              BlocConsumer<OnBoardingCubit, OnBoardingState>(
                builder: (BuildContext context, state) {
                  return BlurredContainer(
                    state: state,
                    localizations: localizations,
                    textTheme: textTheme,
                    controller: controller,
                  );
                },
                listenWhen: (previous, current) =>
                    previous.pageNumber != current.pageNumber,
                listener: (context, state) {
                  controller.animateToPage(
                    state.pageNumber,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ],
          ),

          // Skip Button
          SkipButton(skip: localizations.skip),
        ],
      ),
    );
  }
}
