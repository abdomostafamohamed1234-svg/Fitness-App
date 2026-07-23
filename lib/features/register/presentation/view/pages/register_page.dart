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
import 'package:flowery/config/l10n/translations/app_localizations.dart';
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
        backgroundColor: Theme.of(context).cardTheme.color,
        title: Text(
          AppLocalizations.of(context)!.message,
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        ),
        content: Text(
          message,
          style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              AppLocalizations.of(context)!.ok,
              style: TextStyle(color: Theme.of(context).primaryColor),
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
      builder: (_) => Center(
        child: CircularProgressIndicator(color: Theme.of(context).primaryColor),
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
        backgroundColor: Colors.transparent,
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
                    BlocBuilder<RegisterCubit, RegisterState>(
                      builder: (context, state) {
                        final int currentState = state.currentStepState?.data ?? 0;

                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            CircularProgressIndicator(
                              color: Theme.of(context).primaryColor,
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
                        child: BlocBuilder<RegisterCubit, RegisterState>(
                          builder: (context, state) {
                            final step = state.currentStepState?.data ?? 0;
                            switch (step) {
                              case 0:
                                return const RegisterBody();
                              case 1:
                                return const ChooseGenderWidget();
                              case 2:
                                return const ChooseAgeWidget();
                              case 3:
                                return const ChooseWeightWidget();
                              case 4:
                                return const ChooseHeightWidget();
                              case 5:
                                return const ChooseGoalWidget();
                              case 6:
                                return const ChooseRpalWidget();
                              default:
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