import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/feature/logout/presentation/veiw_model.dart/logout_cubit.dart';
import 'package:flowery/feature/logout/presentation/veiw_model.dart/logout_event.dart';
import 'package:flowery/feature/profile/presentation/view/widget/profile_menu_item.dart';
import 'package:flowery/feature/profile/presentation/view/widget/web_view_screen.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileContent extends StatelessWidget {
  const ProfileContent({
    super.key,
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


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        // ================== HEADER ==================
        Stack(
          alignment: Alignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.profile,
              style: const TextStyle(
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
                  onTap: () {
                    // context.pushNamed(AppRoutes.appSections),
                  },
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
                    title: AppLocalizations.of(context)!.editProfile,
                    onTap: () {
                      // final profileCubit = context.read<ProfileCubit>();

                      // context.pushNamed(
                      //   AppRoutes.editProfile,
                      //   arguments: profileCubit,
                      // );
                    },
                  ),
                  ProfileMenuItem(
                    icon: Icons.lock_reset,
                    title: AppLocalizations.of(context)!.changePassword,
                    onTap: () {
                      // context.pushNamed(AppRoutes.changePassword);
                    },
                  ),
                  ProfileMenuItem(
                    icon: Icons.language,
                    title: AppLocalizations.of(context)!.selectLanguage,
                    trailingText: isEnglish ? AppLocalizations.of(context)!.english : AppLocalizations.of(context)!.arabic,
                    showSwitch: true,
                    switchValue: isEnglish,
                    onSwitchChanged: onLanguageChanged,
                  ),

                  ProfileMenuItem(
                    icon: Icons.settings_outlined,
                    title: AppLocalizations.of(context)!.security,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => WebViewScreen(
                            url:
                                'https://elevate-flutter-team.github.io/fitness-app-webviews/security.html',
                            title: AppLocalizations.of(context)!.security,
                          ),
                        ),
                      );
                    },
                  ),
                  ProfileMenuItem(
                    icon: Icons.settings_outlined,
                    title: AppLocalizations.of(context)!.privacyPolicy,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => WebViewScreen(
                            url:
                                'https://elevate-flutter-team.github.io/fitness-app-webviews/privacy-policy.html',

                            title: AppLocalizations.of(context)!.privacyPolicy,
                          ),
                        ),
                      );
                    },
                  ),
                  ProfileMenuItem(
                    icon: Icons.settings_outlined,
                    title: AppLocalizations.of(context)!.help,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => WebViewScreen(
                            url:
                                'https://elevate-flutter-team.github.io/fitness-app-webviews/help.html',
                            title: AppLocalizations.of(context)!.help,
                          ),
                        ),
                      );
                    },
                  ),

                  ProfileMenuItem(
                    icon: Icons.logout,
                    title: AppLocalizations.of(context)!.logout,
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
                                Text(
                                  AppLocalizations.of(context)!.areYouSureToCloseApplication,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
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
                                            borderRadius: BorderRadius.circular(
                                              30,
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          AppLocalizations.of(context)!.no,
                                          style: const TextStyle(
                                            color: AppColors.primaryColor,
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
                                          backgroundColor:
                                              AppColors.primaryColor,
                                          foregroundColor: Colors.white,
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 14,
                                          ),
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              30,
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          AppLocalizations.of(context)!.yes,
                                          style: const TextStyle(
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
