import 'package:equatable/equatable.dart';
import 'package:flowery/core/base/base_state.dart';
import 'package:flowery/features/chat_bot/data/models/responses/chat/chat_message.dart';
import 'package:flowery/features/chat_bot/data/models/responses/chat/chat_model.dart';

class ChatBotState extends Equatable {
  final bool isWelcome;
  final List<ChatModel>? chats;
  final int selectedChatIndex;
  final BaseState<ChatMessage> chatBotState;
  final BaseState<List<ChatModel>> chatsState;
  final double messageOffset;

  const ChatBotState({
    this.messageOffset = 0.0,
    this.chatsState = const BaseState.initial(),
    this.chatBotState = const BaseState.initial(),
    this.isWelcome = true,
    this.selectedChatIndex = -1,
    this.chats = const [],
  });

  ChatBotState copyWith({
    final bool? isWelcome,
    final List<ChatModel>? chats,
    final int? selectedChatIndex,
    final BaseState<ChatMessage>? chatBotState,
    final double? messageOffset,
    final BaseState<List<ChatModel>>? chatsState
  }) => ChatBotState(
    isWelcome: isWelcome ?? this.isWelcome,
    chats: chats ?? this.chats,
    selectedChatIndex: selectedChatIndex ?? this.selectedChatIndex,
    chatBotState: chatBotState ?? this.chatBotState,
    messageOffset: messageOffset ?? this.messageOffset,
    chatsState: chatsState ?? this.chatsState
  );

  @override
  List<Object?> get props => [
    isWelcome,
    chats,
    selectedChatIndex,
    chatBotState,
    messageOffset,
    chatsState
  ];
}
