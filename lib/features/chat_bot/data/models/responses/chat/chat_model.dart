import 'package:equatable/equatable.dart';
import 'package:flowery/features/chat_bot/data/models/responses/chat/chat_message.dart';

class ChatModel extends Equatable {
  final String chatTitle;
  final List<ChatMessage> messages;

  const ChatModel({required this.chatTitle, required this.messages});

  @override
  List<Object?> get props => [chatTitle, messages];
}
