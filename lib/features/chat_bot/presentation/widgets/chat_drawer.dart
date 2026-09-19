import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/config/routing/routing_extensions.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/features/chat_bot/presentation/view_model/cubit/chat_bot_cubit.dart';
import 'package:flowery/features/chat_bot/presentation/view_model/events/chat_bot_events.dart';
import 'package:flowery/features/chat_bot/presentation/view_model/state/chat_bot_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatDrawer extends StatelessWidget {
  final AppLocalizations localizations;
  final TextTheme textTheme;
  final ChatBotState state;

  const ChatDrawer({
    super.key,
    required this.localizations,
    required this.textTheme,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
          );
  }
}