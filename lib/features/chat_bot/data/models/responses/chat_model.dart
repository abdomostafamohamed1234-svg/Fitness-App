import 'package:flowery/features/chat_bot/data/models/responses/chat_message.dart';

class ChatModel {
  final String chatTitle;
  final List<ChatMessage> messages;

  const ChatModel({required this.chatTitle, required this.messages});
}
