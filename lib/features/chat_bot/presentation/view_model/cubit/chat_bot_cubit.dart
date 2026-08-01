import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/core/base/base_state.dart';
import 'package:flowery/features/chat_bot/data/models/responses/chat_message.dart';
import 'package:flowery/features/chat_bot/data/models/responses/chat_model.dart';
import 'package:flowery/features/chat_bot/domain/entities/chat_bot_entity.dart';
import 'package:flowery/features/chat_bot/domain/use_cases/get_all_chats_use_case.dart';
import 'package:flowery/features/chat_bot/domain/use_cases/send_to_chat_bot_use_case.dart';
import 'package:flowery/features/chat_bot/presentation/view_model/events/chat_bot_events.dart';
import 'package:flowery/features/chat_bot/presentation/view_model/state/chat_bot_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChatBotCubit extends Cubit<ChatBotState> {
  final SendToChatBotUseCase _sendToChatBotUseCase;
  final GetAllChatsUseCase _getAllChatsUseCase;
  ChatBotCubit(this._sendToChatBotUseCase, this._getAllChatsUseCase)
    : super(const ChatBotState());

  void doEvent(ChatBotEvents event) {
    switch (event) {
      case NavigateToChatEvent():
        _navigateToChat();
      case SelectChatEvent():
        _selectChatEvent(event);
      case SendMessageToBotEvent():
        _sendToBot(event);
      case GetPreviousChatsEvent():
        _getPreviousChats(event);
    }
  }

  void _getPreviousChats(GetPreviousChatsEvent event) async {
    emit(state.copyWith(chatsState: const BaseState.loading()));

    final response = await _getAllChatsUseCase.call(userId: event.userId);

    switch (response) {
      case Success<List<ChatModel>>():
        emit(
          state.copyWith(
            chatsState: BaseState.success(response.data),
            chats: response.data,
          ),
        );
      case Error<List<ChatModel>>():
        emit(state.copyWith(chatsState: BaseState.error(response.exception)));
    }
  }

void _sendToBot(SendMessageToBotEvent event) async {
  emit(
    state.copyWith(
      chatBotState: const BaseState.loading(),
    ),
  );

  final selectedChatIndex = _addUserMessageToChat(event);

  final response = await _sendToChatBotUseCase.call(
    message: event.message,
    selectedChat: selectedChatIndex,
    userId: event.userId,
  );

  switch (response) {
    case Success<ChatBotEntity>():
      final chats = List<ChatModel>.from(state.chats ?? []);

      if (selectedChatIndex < 0 ||
          selectedChatIndex >= chats.length) {
        return;
      }

      final currentChat = chats[selectedChatIndex];

      final parts = response.data?.message.split('\n');

      final title = parts?.first.trim() ?? '';

      final message = parts?.skip(1).join('\n').trim() ?? '';

      final botMessage = ChatMessage(
        isBot: true,
        content: message,
      );

      final updatedChat = ChatModel(
        chatTitle: title,
        messages: [
          ...currentChat.messages,
          botMessage,
        ],
      );

      chats[selectedChatIndex] = updatedChat;

      emit(
        state.copyWith(
          chats: chats,
          chatBotState: BaseState.success(botMessage),
        ),
      );

    case Error<ChatBotEntity>():
      emit(
        state.copyWith(
          chatBotState: BaseState.error(response.exception),
        ),
      );
  }
}

int _addUserMessageToChat(SendMessageToBotEvent event) {
  final userMessage = ChatMessage(
    isBot: false,
    content: event.message,
  );

  final chats = List<ChatModel>.from(state.chats ?? []);

  if (state.selectedChatIndex >= 0 &&
      state.selectedChatIndex < chats.length) {
    final currentChat = chats[state.selectedChatIndex];

    final updatedChat = ChatModel(
      chatTitle: currentChat.chatTitle,
      messages: [
        ...currentChat.messages,
        userMessage,
      ],
    );

    chats[state.selectedChatIndex] = updatedChat;

    emit(
      state.copyWith(
        chats: chats,
        messageOffset: event.messageOffset,
      ),
    );

    return state.selectedChatIndex;
  }

  final newChat = ChatModel(
    chatTitle: 'New Chat',
    messages: [userMessage],
  );

  final newChatIndex = chats.length;

  emit(
    state.copyWith(
      chats: [
        ...chats,
        newChat,
      ],
      selectedChatIndex: newChatIndex,
      messageOffset: event.messageOffset,
    ),
  );

  return newChatIndex;
}

  void _selectChatEvent(SelectChatEvent event) {
    emit(state.copyWith(selectedChatIndex: event.chatIndex));
  }

  void _navigateToChat() {
    emit(state.copyWith(isWelcome: false));
  }
}
