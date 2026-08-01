import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/widgets/glass_container.dart';
import 'package:flowery/features/chat_bot/presentation/assets/chat_bot_assets_navigation.dart';
import 'package:flowery/features/chat_bot/presentation/view_model/cubit/chat_bot_cubit.dart';
import 'package:flowery/features/chat_bot/presentation/view_model/events/chat_bot_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatWelcome extends StatelessWidget {
  final double height;
  final double width;
  final AppLocalizations localizations;
  final TextTheme textTheme;

  const ChatWelcome({
    super.key,
    required this.height,
    required this.width,
    required this.localizations,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          ChatBotAssetsNavigation.botImage,
          fit: BoxFit.cover,
          scale: 2,
        ),

        GlassContainer(
          children: [
            Column(
              children: [
                Text(
                  localizations.how_can_i_assist_you,
                  style: textTheme.headlineLarge,
                ),
                Text(localizations.today, style: textTheme.headlineLarge),
                SizedBox(height: height * 0.02),
                SizedBox(
                  height: height * 0.05,
                  width: width * 0.9,
                  child: ElevatedButton(
                    onPressed: () => context.read<ChatBotCubit>().doEvent(
                      NavigateToChatEvent(),
                    ),
                    child: Text(localizations.get_started),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
