import 'dart:ui';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/features/chat_bot/presentation/assets/chat_bot_assets_navigation.dart';
import 'package:flowery/features/chat_bot/presentation/view_model/cubit/chat_bot_cubit.dart';
import 'package:flowery/features/chat_bot/presentation/view_model/state/chat_bot_state.dart';
import 'package:flowery/features/chat_bot/presentation/widgets/chat.dart';
import 'package:flowery/features/chat_bot/presentation/widgets/chat_bot_screen_header.dart';
import 'package:flowery/features/chat_bot/presentation/widgets/chat_drawer.dart';
import 'package:flowery/features/chat_bot/presentation/widgets/chat_input_field.dart';
import 'package:flowery/features/chat_bot/presentation/widgets/chat_welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  late AppLocalizations localizations;
  late TextTheme textTheme;
  final TextEditingController controller = TextEditingController();

  @override
  void didChangeDependencies() {
    localizations = AppLocalizations.of(context)!;
    textTheme = Theme.of(context).textTheme;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatBotCubit, ChatBotState>(
      builder: (context, state) {
        return Scaffold(
          endDrawer: ChatDrawer(
            localizations: localizations,
            textTheme: textTheme,
            state: state,
          ),
          body: LayoutBuilder(
            builder: (context, constraints) {
              final height = constraints.maxHeight;
              final width = constraints.maxWidth;
              return Stack(
                alignment: Alignment.topRight,
                children: [
                  // Background blur image
                  Positioned.fill(
                    child: ImageFiltered(
                      imageFilter: ImageFilter.blur(
                        sigmaX: 3,
                        sigmaY: 5,
                        tileMode: TileMode.clamp,
                      ),
                      child: Image.asset(
                        ChatBotAssetsNavigation.chatBotBackground,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  SafeArea(
                    child: Column(
                      children: [
                        // Header
                        ChatBotScreenHeader(
                          height: height,
                          width: width,
                          localizations: localizations,
                          textTheme: textTheme,
                          state: state,
                        ),
                        SizedBox(height: height * 0.02),

                        state.isWelcome && state.selectedChatIndex == -1
                            // Case: Welcome Screen
                            ? ChatWelcome(
                                height: height,
                                width: width,
                                localizations: localizations,
                                textTheme: textTheme,
                              )
                            // Case: Chat
                            : Column(
                                children: [
                                  Chat(
                                    height: height,
                                    width: width,
                                    state: state,
                                  ),
                                  ChatInputField(
                                    controller: controller,
                                    localizations: localizations,
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
