sealed class ChatBotEvents {}

class NavigateToChatEvent extends ChatBotEvents {}

class SelectChatEvent extends ChatBotEvents {
  final int chatIndex;

  SelectChatEvent({required this.chatIndex});
}
