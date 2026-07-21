import 'package:flowery/config/di/di_config.dart';
import 'package:flowery/core/theme/app_assets.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/features/login/presentation/view/widgets/login_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view_model/cubit.dart';
import '../view_model/state.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (_) => getIt<LoginCubit>(),
      child: Builder(
        builder: (context) {
          final loginCubit = context.read<LoginCubit>();

          return BlocListener<LoginCubit, LoginStates>(
            listener: (context, state) {
              state.loginState.when(
                initial: () {},
                loading: () {},
                success: (data) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(data.message)),
                  );
                  // Navigator.pushReplacementNamed(context, AppRoutes.home);
                },
                error: (exception) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(exception.toString())),
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
                            AppAssets.logo,
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
          );
        },
      ),
    );
  }
}
