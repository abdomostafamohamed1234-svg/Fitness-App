import 'package:dio/dio.dart';
import 'package:flowery/config/exception_handlers/dio_exception_handler.dart';
import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/chat_bot/api/api_client/chat_bot_api_client.dart';
import 'package:flowery/features/chat_bot/data/data_sources/chat_bot_remote_data_sources_contract.dart';
import 'package:flowery/features/chat_bot/data/models/requests/chat_bot_request_body.dart';
import 'package:flowery/features/chat_bot/data/models/responses/chat_bot/chat_bot_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ChatBotRemoteDataSourcesContract)
class ChatBotRemoteDataSourcesImpl implements ChatBotRemoteDataSourcesContract {
  final ChatBotApiClient chatBotApiClient;
  ChatBotRemoteDataSourcesImpl(this.chatBotApiClient);

  @override
  Future<Result<ChatBotResponse>> sendMessageToBot({
    required ChatBotRequestBody body,
  }) async {
    try {
      final response = await chatBotApiClient.sendMessageToBot(body: body);
      return Success<ChatBotResponse>(data: response);
    } on DioException catch (e) {
      return Error<ChatBotResponse>(
        exception: await DioExceptionHandler.handle(e),
      );
    }
  }
}
