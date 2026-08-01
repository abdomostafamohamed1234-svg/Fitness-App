import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/chat_bot/data/models/requests/chat_bot_request_body.dart';
import 'package:flowery/features/chat_bot/data/models/responses/chat_bot/chat_bot_response.dart';

abstract interface class ChatBotRemoteDataSourcesContract{
  Future<Result<ChatBotResponse>> sendMessageToBot({required ChatBotRequestBody body});
}