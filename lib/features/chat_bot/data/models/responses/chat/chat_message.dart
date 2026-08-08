import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'chat_message.g.dart';

@JsonSerializable()
class ChatMessage extends Equatable{
  final bool isBot;
  final String content;

  const ChatMessage({required this.isBot, required this.content});

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);

  Map<String, dynamic> toJson() => _$ChatMessageToJson(this);
  
  @override
  List<Object?> get props => [isBot,content];
}
