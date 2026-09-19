import 'package:flowery/features/chat_bot/domain/entities/chat_bot_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'chat_bot_response.g.dart';

@JsonSerializable()
class ChatBotResponse {
  @JsonKey(name: "model")
  String? model;
  @JsonKey(name: "created_at")
  DateTime? createdAt;
  @JsonKey(name: "message")
  Message? message;
  @JsonKey(name: "done")
  bool? done;
  @JsonKey(name: "done_reason")
  String? doneReason;
  @JsonKey(name: "total_duration")
  int? totalDuration;
  @JsonKey(name: "prompt_eval_count")
  int? promptEvalCount;
  @JsonKey(name: "eval_count")
  int? evalCount;

  ChatBotResponse({
    this.model,
    this.createdAt,
    this.message,
    this.done,
    this.doneReason,
    this.totalDuration,
    this.promptEvalCount,
    this.evalCount,
  });

  factory ChatBotResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatBotResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChatBotResponseToJson(this);

  ChatBotEntity toEntity() {
    // Spliting the title from the message
    final parts = message?.content?.split('\n');
    final title = parts?.first.trim();
    final botMessage = parts?.skip(1).join('\n').trim();
    return ChatBotEntity(botMessage: botMessage ?? "", title: title ?? "");
  }
}

@JsonSerializable()
class Message {
  @JsonKey(name: "role")
  String? role;
  @JsonKey(name: "content")
  String? content;
  @JsonKey(name: "thinking")
  String? thinking;

  Message({this.role, this.content, this.thinking});

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
