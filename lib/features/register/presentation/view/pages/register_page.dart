import 'package:flowery/config/di/di_config.dart';
import 'package:flowery/config/routing/app_routes.dart';
import 'package:flowery/core/theme/app_assets.dart';
import 'package:flowery/features/register/presentation/view/widgets/choose_age_widget.dart';
import 'package:flowery/features/register/presentation/view/widgets/choose_gender_widget.dart';
import 'package:flowery/features/register/presentation/view/widgets/choose_goal_widget.dart';
import 'package:flowery/features/register/presentation/view/widgets/choose_height_widget.dart';
import 'package:flowery/features/register/presentation/view/widgets/choose_rpal_widget.dart';
import 'package:flowery/features/register/presentation/view/widgets/choose_weight_widget.dart';
import 'package:flowery/features/register/presentation/view/widgets/register_body.dart';
import 'package:flowery/features/register/presentation/view_model/cubit/register_cubit.dart';
import 'package:flowery/features/register/presentation/view_model/cubit/register_events.dart';
import 'package:flowery/features/register/presentation/view_model/cubit/register_states.dart';
import 'package:flowery/features/register/presentation/view_model/cubit/register_temp_events.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final RegisterCubit registerCubit;

  @override
  void initState() {
    super.initState();
    registerCubit = getIt<RegisterCubit>();

    if (registerCubit.firstTime) {
      registerCubit.doIntent(RegisterNextStep());
      registerCubit.firstTime = false;
    }

    registerCubit.cubitStream.listen((event) {
      switch (event) {
        case NavigateToLoginTempEvent():
          if (mounted) {
            Navigator.pushReplacementNamed(context, AppRoutes.login);
          }
        case ShowMassageTempEvent():
          if (mounted) {
            _showMessageDialog(event.message);
          }
        case ShowLoadingTempEvent():
          if (mounted) {
            _showLoading();
          }
        case HideLoadingTempEvent():
          if (mounted) {
            Navigator.of(context, rootNavigator: true).maybePop();
          }
      }
    });
  }

  void _showMessageDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.darkGreyColor,
        title: const Text(
          'Message',
          style: TextStyle(color: AppColors.whiteColor),
        ),
        content: Text(
          message,
          style: const TextStyle(color: AppColors.greyColor),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(
              'OK',
              style: TextStyle(color: AppColors.primaryColor),
            ),
          ),
        ],
      ),
    );
  }

  void _showLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: CircularProgressIndicator(color: AppColors.primaryColor),
      ),
    );
  }

  @override
  void dispose() {
    registerCubit.emailController.dispose();
    registerCubit.firstNameController.dispose();
    registerCubit.lastNameController.dispose();
    registerCubit.passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  

    return BlocProvider<RegisterCubit>(
      create: (_) => registerCubit,
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        extendBodyBehindAppBar: true,
        body: SafeArea(
          child: Stack(
            children: [
              Image.asset(
                AppAssets.registerBackGround,
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.fill,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    Image.asset(
                      AppAssets.fitnessSplash,
                      height: 100,
                      width: 100,
                    ),

                    const SizedBox(height: 50),
                    BlocBuilder<RegisterCubit, RegisterStates>(
                      builder: (context, state) {
                        final int currentState = state.registerState?.data ?? 0;

                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            CircularProgressIndicator(
                              color: AppColors.primaryColor,
                              value: currentState / 6,
                            ),
                            Text("$currentState/6"),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: SingleChildScrollView(
                        child: BlocBuilder<RegisterCubit, RegisterStates>(
                          builder: (context, state) {
                            final step = state.registerState?.data ?? 0;
                            if (step == 0) {
                              return RegisterBody(registerCubit: registerCubit);
                            } else if (step == 1) {
                              return ChooseGenderWidget(
                                registerCubit: registerCubit,
                              );
                            } else if (step == 2) {
                              return ChooseAgeWidget(
                                registerCubit: registerCubit,
                              );
                            } else if (step == 3) {
                              return ChooseWeightWidget(
                                registerCubit: registerCubit,
                              );
                            } else if (step == 4) {
                              return ChooseHeightWidget(
                                registerCubit: registerCubit,
                              );
                            } else if (step == 5) {
                              return ChooseGoalWidget(
                                registerCubit: registerCubit,
                              );
                            } else if (step == 6) {
                              return ChooseRpalWidget(
                                registerCubit: registerCubit,
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
