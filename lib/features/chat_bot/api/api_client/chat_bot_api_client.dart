import 'package:dio/dio.dart';
import 'package:flowery/features/chat_bot/data/models/requests/chat_bot_request_body.dart';
import 'package:flowery/features/chat_bot/data/models/responses/chat_bot/chat_bot_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'chat_bot_api_client.g.dart';

@injectable
@RestApi()
abstract class ChatBotApiClient {
  @factoryMethod
  factory ChatBotApiClient(@Named("chatBotDio") Dio dio) = _ChatBotApiClient;

  @POST("")
  Future<ChatBotResponse> sendMessageToBot({@Body() required ChatBotRequestBody body});
}
