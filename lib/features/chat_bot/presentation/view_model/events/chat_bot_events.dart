sealed class ChatBotEvents {}

class NavigateToChatEvent extends ChatBotEvents {}

class GetPreviousChatsEvent extends ChatBotEvents {
  final String userId;

  GetPreviousChatsEvent({required this.userId});
}

class SendMessageToBotEvent extends ChatBotEvents {
  final String userId;
  final String message;
  final double messageOffset;
  SendMessageToBotEvent({
    required this.message,
    required this.messageOffset,
    required this.userId,
  });
}

class SelectChatEvent extends ChatBotEvents {
  final int chatIndex;

  SelectChatEvent({required this.chatIndex});
}
