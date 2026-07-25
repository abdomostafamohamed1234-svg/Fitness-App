import 'package:flowery/config/di/di_config.dart';
import 'package:flowery/config/routing/app_routes.dart';
import 'package:flowery/core/base/base_state.dart';
import 'package:flowery/features/auth_with_social_media/presentation/view/widgets/social_button_temp.dart';
import 'package:flowery/features/auth_with_social_media/domain/entities/social_auth_result.dart';
import 'package:flowery/features/auth_with_social_media/presentation/view_model/cubit/social_auth_cubit.dart';
import 'package:flowery/features/auth_with_social_media/presentation/view_model/events/social_auth_event.dart';
import 'package:flowery/features/auth_with_social_media/presentation/view_model/base_state/social_auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialAuthButtonsRow extends StatelessWidget {
  const SocialAuthButtonsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SocialAuthBloc>(
      create: (_) => getIt<SocialAuthBloc>(),
      child: BlocConsumer<SocialAuthBloc, SocialAuthState>(
        listener: (context, state) {
          state.when(
            initial: () {},
            loading: () {},
            success: (result) {
              switch (result) {
                case ExistingUserAuthResult():
                // Navigator.pushReplacementNamed(context, AppRoutes.home);

                case NewUserAuthResult(:final session):
                // Navigator.pushReplacementNamed(
                //   context,
                //   AppRoutes.register,
                //   arguments: SocialRegisterArgs(
                //     provider: session.user.provider,
                //     token: session.user.providerToken,
                //   ),
                // );
              }
            },
            error: (exception) {
              ScaffoldMessenger.maybeOf(
                context,
              )?.showSnackBar(SnackBar(content: Text(exception.toString())));
            },
          );
        },
        builder: (context, state) {
          final isLoading = state.state == StateType.loading;

          return Stack(
            alignment: Alignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialButton(
                    icon: Icons.facebook,
                    onTap: isLoading
                        ? () {}
                        : () => context.read<SocialAuthBloc>().add(
                            const FacebookSignInEvent(),
                          ),
                  ),
                  const SizedBox(width: 20),
                  SocialButton(
                    label: 'G',
                    onTap: isLoading
                        ? () {}
                        : () => context.read<SocialAuthBloc>().add(
                            const GoogleSignInEvent(),
                          ),
                  ),
                  const SizedBox(width: 20),
                  SocialButton(icon: Icons.apple, onTap: () {}),
                ],
              ),
              if (isLoading)
                const Positioned(
                  right: -36,
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2.5),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
