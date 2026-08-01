import 'package:equatable/equatable.dart';

class ChatBotEntity extends Equatable {
  final String message;
  const ChatBotEntity({required this.message});

  @override
  List<Object?> get props => [message];
}
