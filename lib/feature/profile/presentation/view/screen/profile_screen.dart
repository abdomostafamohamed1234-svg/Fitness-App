import 'package:flowery/config/di/di_config.dart';
import 'package:flowery/config/routing/app_routes.dart';
import 'package:flowery/feature/logout/presentation/veiw_model.dart/logout_cubit.dart';
import 'package:flowery/feature/logout/presentation/veiw_model.dart/logout_state.dart';
import 'package:flowery/feature/profile/presentation/view/widget/profile_content.dart';
import 'package:flowery/feature/profile/presentation/view_model/profile_cubit.dart';
import 'package:flowery/feature/profile/presentation/view_model/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => getIt<LogoutCubit>())],
      child: const _ProfileView(),
    );
  }
}

class _ProfileView extends StatefulWidget {
  const _ProfileView();

  @override
  State<_ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<_ProfileView> {
  bool isEnglish = true;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LogoutCubit, LogoutStates>(
      listener: (context, state) {
        state.logoutState.when(
          initial: () {},
          loading: () {},
          success: (_) {
            Navigator.of(
              context,
            ).pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
          },
          error: (exception) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('فشل تسجيل الخروج، حاولي تاني')),
            );
          },
        );
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0E0E0E),
        body: Stack(
          fit: StackFit.expand,
          children: [
            // خلفية الصورة + بلور + أوفرلاي غامق زي الديزاين
            Image.asset(
              'assets/BackGroundProfile.png', // حطي مسار صورة الخلفية عندك
              fit: BoxFit.cover,
            ),
            SafeArea(
              child: BlocBuilder<ProfileCubit, ProfileStates>(
                builder: (context, state) {
                  return state.profileState.when(
                    initial: () => const SizedBox.shrink(),
                    loading: () => const Center(
                      child: CircularProgressIndicator(color: Colors.amber),
                    ),
                    error: (exception) => Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Text(
                          'حصل خطأ أثناء تحميل البروفايل\n$exception',
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    success: (data) => ProfileContent(
                      name: data.name,
                      imageUrl: data.profileImage,
                      isEnglish: isEnglish,
                      onLanguageChanged: (value) =>
                          setState(() => isEnglish = value),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
