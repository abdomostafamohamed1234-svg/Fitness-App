import 'dart:ui';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/config/routing/routing_extensions.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/features/chat_bot/presentation/assets/chat_bot_assets_navigation.dart';
import 'package:flowery/features/chat_bot/presentation/view_model/cubit/chat_bot_cubit.dart';
import 'package:flowery/features/chat_bot/presentation/view_model/events/chat_bot_events.dart';
import 'package:flowery/features/chat_bot/presentation/view_model/state/chat_bot_state.dart';
import 'package:flowery/features/chat_bot/presentation/widgets/chat.dart';
import 'package:flowery/features/chat_bot/presentation/widgets/chat_bot_screen_header.dart';
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
          endDrawer: Drawer(
            backgroundColor: AppColors.borderColor.withValues(alpha: 0.75),
            width: MediaQuery.of(context).size.width * 0.7,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 30,
                  ),
                  child: Text(
                    localizations.previous_conversations,
                    style: textTheme.headlineMedium,
                    textAlign: TextAlign.right,
                  ),
                ),
                Column(
                  children:
                      state.chats
                          ?.map(
                            (chat) => Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    context.read<ChatBotCubit>().doEvent(
                                      SelectChatEvent(
                                        chatIndex: state.chats!.indexOf(chat),
                                      ),
                                    );
                                    context.pop();
                                  },
                                  child: SizedBox(
                                    height: 30,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const Icon(
                                          Icons.arrow_back_ios_new,
                                          size: 15,
                                          color: AppColors.primaryColor,
                                        ),

                                        Row(
                                          children: [
                                            SizedBox(
                                              width:
                                                  MediaQuery.of(
                                                    context,
                                                  ).size.width *
                                                  0.6,
                                              child: Text(
                                                chat.chatTitle,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            SizedBox(
                                              width:
                                                  MediaQuery.of(
                                                    context,
                                                  ).size.width *
                                                  0.02,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                  ),
                                  child: Divider(
                                    thickness: 1,
                                    color: AppColors.borderColor,
                                  ),
                                ),
                              ],
                            ),
                          )
                          .toList() ??
                      [],
                ),
              ],
            ),
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
