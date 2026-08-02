import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/base/base_state.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/features/chat_bot/presentation/view_model/cubit/chat_bot_cubit.dart';
import 'package:flowery/features/chat_bot/presentation/view_model/events/chat_bot_events.dart';
import 'package:flowery/features/chat_bot/presentation/view_model/state/chat_bot_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatInputField extends StatelessWidget {
  final ScrollController scrollController;
  final TextEditingController chatController;
  final AppLocalizations localizations;
  final ChatBotState state;
  final String userId;
  const ChatInputField({
    super.key,
    required this.chatController,
    required this.localizations,
    required this.state,
    required this.scrollController,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                controller: chatController,
                decoration: InputDecoration(
                  hintText: localizations.fitness_hint_text,
                  hintStyle: TextStyle(
                    color: AppColors.lightGreyColor.withValues(alpha: 0.6),
                  ),
                ),
              ),
            ),
          ),
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: chatController,
            builder: (context, value, child) {
              final isLoading = state.chatBotState.state == StateType.loading;

              final hasText = value.text.trim().isNotEmpty;

              final isEnabled = !isLoading && hasText;

              return IconButton(
                onPressed: isEnabled
                    ? () async {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (scrollController.hasClients) {
                            scrollController.animateTo(
                              scrollController.position.maxScrollExtent,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                            );
                          }
                        });

                        final savedOffset =
                            scrollController.position.maxScrollExtent;

                        context.read<ChatBotCubit>().doEvent(
                          SendMessageToBotEvent(
                            userId: userId,
                            message: value.text.trim(),
                            messageOffset: savedOffset,
                          ),
                        );

                        chatController.clear();
                      }
                    : null,
                icon: Icon(
                  Icons.send,
                  color: isEnabled
                      ? AppColors.primaryColor
                      : AppColors.lightGreyColor,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
