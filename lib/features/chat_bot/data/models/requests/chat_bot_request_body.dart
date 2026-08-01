import 'package:json_annotation/json_annotation.dart';

part 'chat_bot_request_body.g.dart';

@JsonSerializable()
class ChatBotRequestBody {
    @JsonKey(name: "model")
    String? model;
    @JsonKey(name: "messages")
    List<ClientMessage>? messages;
    @JsonKey(name: "stream")
    bool? stream;

    ChatBotRequestBody({
        this.model,
        this.messages,
        this.stream,
    });

    factory ChatBotRequestBody.fromJson(Map<String, dynamic> json) => _$ChatBotRequestBodyFromJson(json);

    Map<String, dynamic> toJson() => _$ChatBotRequestBodyToJson(this);
}

@JsonSerializable()
class ClientMessage {
    @JsonKey(name: "role")
    String? role;
    @JsonKey(name: "content")
    String? content;

    ClientMessage({
        this.role,
        this.content,
    });

    factory ClientMessage.fromJson(Map<String, dynamic> json) => _$ClientMessageFromJson(json);

    Map<String, dynamic> toJson() => _$ClientMessageToJson(this);
}
