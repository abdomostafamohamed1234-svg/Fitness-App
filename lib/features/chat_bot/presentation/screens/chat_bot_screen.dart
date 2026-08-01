import 'dart:ui';
import 'package:flowery/config/di/di_config.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/base/base_state.dart';
import 'package:flowery/features/chat_bot/presentation/assets/chat_bot_assets_navigation.dart';
import 'package:flowery/features/chat_bot/presentation/view_model/cubit/chat_bot_cubit.dart';
import 'package:flowery/features/chat_bot/presentation/view_model/events/chat_bot_events.dart';
import 'package:flowery/features/chat_bot/presentation/view_model/state/chat_bot_state.dart';
import 'package:flowery/features/chat_bot/presentation/widgets/chat.dart';
import 'package:flowery/features/chat_bot/presentation/widgets/chat_bot_screen_header.dart';
import 'package:flowery/features/chat_bot/presentation/widgets/chat_drawer.dart';
import 'package:flowery/features/chat_bot/presentation/widgets/chat_input_field.dart';
import 'package:flowery/features/chat_bot/presentation/widgets/chat_welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBotScreen extends StatefulWidget {
  final String userId;
  final String userFirstName;
  final String userImage;
  const ChatBotScreen({
    super.key,
    required this.userId,
    required this.userFirstName,
    required this.userImage,
  });

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  late AppLocalizations localizations;
  late TextTheme textTheme;
  final TextEditingController chatController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  void didChangeDependencies() {
    localizations = AppLocalizations.of(context)!;
    textTheme = Theme.of(context).textTheme;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt.get<ChatBotCubit>()
            ..doEvent(GetPreviousChatsEvent(userId: widget.userId)),
      child: BlocConsumer<ChatBotCubit, ChatBotState>(
        builder: (context, state) {
          return state.chatsState.when(
            success: (data) {
              return Scaffold(
                endDrawer: ChatDrawer(
                  localizations: localizations,
                  textTheme: textTheme,
                  state: state,
                ),
                body: Stack(
                  fit: StackFit.expand,
                  children: [
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
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final height = constraints.maxHeight;
                          final width = constraints.maxWidth;
                          return Column(
                            children: [
                              ChatBotScreenHeader(
                                height: height,
                                width: width,
                                localizations: localizations,
                                textTheme: textTheme,
                                state: state,
                                firstName: widget.userFirstName,
                              ),
                              SizedBox(height: height * 0.02),
                              Expanded(
                                child:
                                    state.isWelcome &&
                                        state.selectedChatIndex == -1
                                    ? ChatWelcome(
                                        height: height,
                                        width: width,
                                        localizations: localizations,
                                        textTheme: textTheme,
                                      )
                                    : Column(
                                        children: [
                                          Expanded(
                                            child: Chat(
                                              height: height,
                                              width: width,
                                              state: state,
                                              scrollController:
                                                  scrollController,
                                              userImg: widget.userImage,
                                            ),
                                          ),

                                          ChatInputField(
                                            chatController: chatController,
                                            scrollController: scrollController,
                                            localizations: localizations,
                                            state: state,
                                            userId: widget.userId,
                                          ),
                                        ],
                                      ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
            loading: () => Center(
              child: Stack(
                fit: StackFit.expand,
                children: [
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
                  const Center(
                    child: SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ],
              ),
            ),
            error: (error) => Center(child: Text(error.toString())),
            initial: () => const SizedBox.shrink(),
          );
        },
        listener: (context, state) {
          if (state.chatBotState.state == StateType.success) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (scrollController.hasClients) {
                scrollController.animateTo(
                  (state.messageOffset + 650),
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              }
            });
          }
        },
      ),
    );
  }
}

class ChatBotArgs {
  final String userId;
  final String userImage;
  final String userFirstName;

  const ChatBotArgs({
    this.userId = "123456",
    this.userImage =
        "https://img.magnific.com/free-photo/young-bearded-man-with-striped-shirt_273609-5677.jpg?semt=ais_test_b&w=740&q=80",
    this.userFirstName = "Ahmed",
  });
}
