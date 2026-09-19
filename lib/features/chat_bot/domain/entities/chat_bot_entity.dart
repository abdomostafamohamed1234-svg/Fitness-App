import 'package:equatable/equatable.dart';

class ChatBotEntity extends Equatable {
  final String botMessage;
  final String title;
  const ChatBotEntity({required this.botMessage, required this.title});

  @override
  List<Object?> get props => [botMessage, title];
}
