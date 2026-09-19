import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ChangePasswordHeader extends StatelessWidget {
  const ChangePasswordHeader({super.key});

  @override
  Widget build(BuildContext context) {
       final localizations = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Image.asset(
            'assets/image.png',
            height: 90,
          ),
        ),
        const SizedBox(height: 32),
        Text(
          localizations.make_sure_8_chara,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: AppColors.lightGreyColor),
        ),
        const SizedBox(height: 6),
        Text(
          localizations.create_new_password,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color:AppColors.whiteColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}