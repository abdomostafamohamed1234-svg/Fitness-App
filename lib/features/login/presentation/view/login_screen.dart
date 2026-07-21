import 'package:flowery/config/di/di_config.dart';
import 'package:flowery/core/theme/app_assets.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/features/login/presentation/view/widgets/login_body.dart';
import 'package:flowery/features/login/presentation/view_model/cubit/login_cubit.dart';
import 'package:flowery/features/login/presentation/view_model/cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view_model/cubit.dart';
import '../view_model/state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final LoginCubit loginCubit;

  @override
  void initState() {
    super.initState();
    loginCubit = getIt();
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
        child: CircularProgressIndicator(
          color: AppColors.primaryColor,
        ),
      ),
    );
  }

  @override
  void dispose() {
    loginCubit.emailController.dispose();
    loginCubit.passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (_) => loginCubit,
      child: BlocListener<LoginCubit, LoginStates>(
        listener: (context, state) {
          state.loginState.when(
            initial: () {},

            loading: () {
              _showLoading();
            },

            success: (data) {
              Navigator.of(context, rootNavigator: true).maybePop();

              _showMessageDialog(
                data.message ?? "Login Successfully",
              );

              // Navigator.pushReplacementNamed(context, AppRoutes.home);
            },

            error: (exception) {
              Navigator.of(context, rootNavigator: true).maybePop();

              _showMessageDialog(
                exception.toString(),
              );
            },
          );
        },
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
                      Expanded(
                        child: SingleChildScrollView(
                          child: LoginBody(
                            loginCubit: loginCubit,
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
      ),
    );
  }
}