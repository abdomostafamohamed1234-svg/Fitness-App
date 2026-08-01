import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/config/routing/routing_extensions.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/features/chat_bot/presentation/view_model/state/chat_bot_state.dart';
import 'package:flutter/material.dart';

class ChatBotScreenHeader extends StatelessWidget {
  final double height;
  final double width;
  final AppLocalizations localizations;
  final TextTheme textTheme;
  final ChatBotState state;
  final String firstName;

  const ChatBotScreenHeader({
    super.key,
    required this.height,
    required this.width,
    required this.localizations,
    required this.textTheme,
    required this.state,
    required this.firstName,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: width * 0.06,
          height: height * 0.06,
          decoration: const BoxDecoration(
            color: AppColors.primaryColor,
            shape: BoxShape.circle,
          ),
          child: InkWell(
            onTap: () => context.pop(),
            customBorder: const CircleBorder(),
            child: const Center(child: Icon(Icons.first_page, size: 18)),
          ),
        ),
        state.isWelcome
            ? Column(
                children: [
                  SizedBox(
                    height: height * 0.03,
                    child: Text(
                      "${localizations.hi} $firstName,\n",
                      style: textTheme.titleMedium,
                    ),
                  ),
                  Text(
                    "${localizations.i_am_your} ${localizations.smart_coach}",
                    style: textTheme.titleLarge,
                  ),
                ],
              )
            : Text(localizations.smart_coach, style: textTheme.headlineLarge),
        InkWell(
          onTap: () {
            Scaffold.of(context).openEndDrawer();
          },
          customBorder: const CircleBorder(),
          child: const Center(
            child: Icon(Icons.segment, size: 24, color: AppColors.primaryColor),
          ),
        ),
      ],
    );
  }
}
