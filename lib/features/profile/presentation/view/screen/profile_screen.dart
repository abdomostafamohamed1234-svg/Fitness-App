import 'dart:ui';
import 'package:flowery/config/di/di_config.dart';
import 'package:flowery/config/routing/app_routes.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/features/logout/presentation/veiw_model.dart/logout_cubit.dart';
import 'package:flowery/features/logout/presentation/veiw_model.dart/logout_event.dart';
import 'package:flowery/features/logout/presentation/veiw_model.dart/logout_state.dart';
import 'package:flowery/features/profile/presentation/view/widget/profile_menu_item.dart';
import 'package:flowery/features/profile/presentation/view_model/profile_cubit.dart';
import 'package:flowery/features/profile/presentation/view_model/profile_event.dart';
import 'package:flowery/features/profile/presentation/view_model/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // static const Color _accent = Color(0xFFFF5A36);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
  providers: [
    BlocProvider(create: (_) => getIt<ProfileCubit>()..doAction(const GetProfileDataEvent())),
    BlocProvider(create: (_) => getIt<LogoutCubit>()),
  ],
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
            Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutes.login,
              (route) => false,
            );
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
              'assets/images/profile_background.jpg', // حطي مسار صورة الخلفية عندك
              fit: BoxFit.cover,
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
              child: Container(color: Colors.black.withValues(alpha: 0.55)),
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
                    success: (data) => _ProfileContent(
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

class _ProfileContent extends StatelessWidget {
  const _ProfileContent({
    required this.name,
    required this.imageUrl,
    required this.isEnglish,
    required this.onLanguageChanged,
  });

  final String name;
  final String? imageUrl;
  final bool isEnglish;
  final ValueChanged<bool> onLanguageChanged;

  static const Color _accent = Color(0xFFFF5A36);

  Future<void> _openLink(BuildContext context, String url) async {
    final uri = Uri.parse(url);
    final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!launched && context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('تعذر فتح الرابط')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        // ================== HEADER ==================
        Stack(
          alignment: Alignment.center,
          children: [
            const Text(
              'Profile',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: InkWell(
                  onTap: () => Navigator.of(context).maybePop(),
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: const BoxDecoration(
                      color: _accent,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.chevron_left, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // ================== AVATAR ==================
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 3),
          ),
          child: ClipOval(
            child: imageUrl != null && imageUrl!.isNotEmpty
                ? Image.network(imageUrl!, fit: BoxFit.cover)
                : Container(
                    color: Colors.grey.shade700,
                    child: const Icon(
                      Icons.person,
                      size: 48,
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),

        // ================== MENU CARD ==================
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.55),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
              ),
              child: Column(
                children: [
                  ProfileMenuItem(
                    icon: Icons.person_outline,
                    title: 'Edit Profile',
                    onTap: () {
                      // TODO: روحي لشاشة Edit Profile
                    },
                  ),
                  ProfileMenuItem(
                    icon: Icons.lock_reset,
                    title: 'Change Password',
                    onTap: () {
                      // TODO: روحي لشاشة Change Password
                    },
                  ),
                  ProfileMenuItem(
                    icon: Icons.language,
                    title: 'Select Language',
                    trailingText: isEnglish ? 'English' : 'Arabic',
                    showSwitch: true,
                    switchValue: isEnglish,
                    onSwitchChanged: onLanguageChanged,
                  ),
                  ProfileMenuItem(
                    icon: Icons.settings_outlined,
                    title: 'Security',
                    onTap: () {
                      _openLink(
                        context,
                        'https://elevate-flutter-team.github.io/fitness-app-webviews/security.html',
                      );
                    },
                  ),
                  ProfileMenuItem(
                    icon: Icons.shield_outlined,
                    title: 'Privacy Policy',
                    onTap: () {
                         _openLink(
                        context,
                        'https://elevate-flutter-team.github.io/fitness-app-webviews/privacy-policy.html',
                      );
                    },
                  ),
                  ProfileMenuItem(
                    icon: Icons.support_agent_outlined,
                    title: 'Help',
                    onTap: () {
                          _openLink(
                        context,
                        'https://elevate-flutter-team.github.io/fitness-app-webviews/help.html',
                      );
                    },
                  ),
                  ProfileMenuItem(
                    icon: Icons.logout,
                    title: 'Logout',
                    isDestructive: true,
                    onTap: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        barrierColor: Colors.black.withValues(alpha: 0.6),
                        builder: (dialogCtx) => Dialog(
                          backgroundColor: Colors.transparent,
                          insetPadding: const EdgeInsets.symmetric(
                            horizontal: 24,
                          ),
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(20, 28, 20, 20),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E1E1E),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'Are You Sure To Close Application?',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    height: 1.3,
                                  ),
                                ),
                                const SizedBox(height: 24),
                                Row(
                                  children: [
                                    Expanded(
                                      child: OutlinedButton(
                                        onPressed: () =>
                                            Navigator.pop(dialogCtx, false),
                                        style: OutlinedButton.styleFrom(
                                          side: const BorderSide(
                                            color: _accent,
                                            width: 1.5,
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 14,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                        ),
                                        child: const Text(
                                          'NO',
                                          style: TextStyle(
                                            color:AppColors.primaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 50),
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () =>
                                            Navigator.pop(dialogCtx, true),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.primaryColor,
                                          foregroundColor: Colors.white,
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 14,
                                          ),
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                        ),
                                        child: const Text(
                                          'Yes',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                      if (confirm == true && context.mounted) {
                        context.read<LogoutCubit>().doAction(
                          const DoLogoutEvent(),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}


