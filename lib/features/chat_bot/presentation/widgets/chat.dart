import 'package:cached_network_image/cached_network_image.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/features/chat_bot/presentation/assets/chat_bot_assets_navigation.dart';
import 'package:flowery/features/chat_bot/presentation/view_model/state/chat_bot_state.dart';
import 'package:flutter/material.dart';

class Chat extends StatelessWidget {
  final double height;
  final double width;
  final ChatBotState state;
  const Chat({
    super.key,
    required this.height,
    required this.width,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height * 0.76,
      child: SingleChildScrollView(
        child: Column(
          children: (state.selectedChatIndex == -1)
              ? []
              : state.chats![state.selectedChatIndex].messages
                    .map(
                      (message) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: message.isBot
                              ? MainAxisAlignment.start
                              : MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: width * 0.1,
                              width: width * 0.1,
                              child: ClipRRect(
                                borderRadius: BorderRadiusGeometry.circular(
                                  100,
                                ),
                                child: message.isBot
                                    ? Image.asset(
                                        ChatBotAssetsNavigation.botIcon,
                                        fit: BoxFit.cover,
                                      )
                                    : const SizedBox.shrink(),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: Container(
                                width: width * 0.6,
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
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(message.content),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: width * 0.1,
                              width: width * 0.1,
                              child: ClipRRect(
                                borderRadius: BorderRadiusGeometry.circular(
                                  100,
                                ),
                                child: !message.isBot
                                    ? CachedNetworkImage(
                                        imageUrl: state.imageUrl ?? "",
                                        fit: BoxFit.cover,
                                      )
                                    : const SizedBox.shrink(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
        ),
      ),
    );
  }
}
