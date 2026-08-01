import 'package:cached_network_image/cached_network_image.dart';
import 'package:flowery/core/base/base_state.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/features/chat_bot/presentation/assets/chat_bot_assets_navigation.dart';
import 'package:flowery/features/chat_bot/presentation/view_model/state/chat_bot_state.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class Chat extends StatelessWidget {
  final double height;
  final double width;
  final ChatBotState state;
  final ScrollController scrollController;
  final String userImg;
  const Chat({
    super.key,
    required this.height,
    required this.width,
    required this.state,
    required this.scrollController,
    required this.userImg,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height * 0.76,
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            if (state.selectedChatIndex >= 0 &&
                state.selectedChatIndex < state.chats!.length)
              ...state.chats![state.selectedChatIndex].messages.map(
                (message) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: message.isBot
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ChatBot Icon
                      SizedBox(
                        height: width * 0.1,
                        width: width * 0.1,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: message.isBot
                              ? Image.asset(
                                  ChatBotAssetsNavigation.botIcon,
                                  fit: BoxFit.cover,
                                )
                              : const SizedBox.shrink(),
                        ),
                      ),

                      // Text Container
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: width * 0.5),
                          child: Container(
                            decoration: BoxDecoration(
                              color: message.isBot
                                  ? AppColors.borderColor
                                  : AppColors.orangeColor,
                              borderRadius: BorderRadius.only(
                                bottomLeft: const Radius.circular(10),
                                bottomRight: const Radius.circular(10),
                                topRight: message.isBot
                                    ? const Radius.circular(10)
                                    : const Radius.circular(0),
                                topLeft: message.isBot
                                    ? const Radius.circular(0)
                                    : const Radius.circular(10),
                              ),
                            ),
                            padding: const EdgeInsets.all(8),
                            child: MarkdownBody(
                              data: message.content,
                              styleSheet: MarkdownStyleSheet(
                                tableHead: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 7,
                                ),
                                tableBody: const TextStyle(fontSize: 7),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Profile Image
                      SizedBox(
                        height: width * 0.1,
                        width: width * 0.1,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: !message.isBot
                              ? CachedNetworkImage(
                                  imageUrl: userImg,
                                  fit: BoxFit.cover,
                                )
                              : const SizedBox.shrink(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            if (state.chatBotState.state == StateType.loading)
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Bot icon
                      SizedBox(
                        height: width * 0.1,
                        width: width * 0.1,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                            ChatBotAssetsNavigation.botIcon,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      // Lottie
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.borderColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Lottie.asset(
                            ChatBotAssetsNavigation.threeDotsAnimation,
                            width: width * 0.1,
                            height: width * 0.1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
