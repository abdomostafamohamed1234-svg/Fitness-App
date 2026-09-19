import 'package:flowery/config/api/api_keys.dart';
import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/chat_bot/data/data_sources/chat_bot_remote_data_sources_contract.dart';
import 'package:flowery/features/chat_bot/data/models/requests/chat_bot_request_body.dart';
import 'package:flowery/features/chat_bot/data/models/responses/chat_bot/chat_bot_response.dart';
import 'package:flowery/features/chat_bot/data/models/responses/chat/chat_message.dart';
import 'package:flowery/features/chat_bot/data/models/responses/chat/chat_model.dart';
import 'package:flowery/features/chat_bot/domain/entities/chat_bot_entity.dart';
import 'package:flowery/features/chat_bot/domain/repo/chat_bot_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ChatBotRepoContract)
class ChatBotRepoImpl implements ChatBotRepoContract {
  final ChatBotRemoteDataSourcesContract _dataSourcesContract;
  ChatBotRepoImpl(this._dataSourcesContract);

  @override
  Future<Result<ChatBotEntity>> sendMessageToBot({
    required String userId,
    required int selectedChat,
    required String message,
  }) async {
    // sending the message to firebase
    _dataSourcesContract.addMessage(
      userId: userId,
      chatId: selectedChat.toString(),
      message: ChatMessage(isBot: false, content: message),
      chatTitle: "",
    );

    // sending the message to the bot
    final response = await _dataSourcesContract.sendMessageToBot(
      body: ChatBotRequestBody(
        model: ApiKeys.modelType,
        stream: false,
        messages: [
          ClientMessage(
            content: ApiKeys.fitnessSystemPrompt,
            role: ApiKeys.system,
          ),
          ClientMessage(content: message, role: ApiKeys.user),
        ],
      ),
    );

    switch (response) {
      case Success<ChatBotResponse>():
        final ChatBotEntity? message = response.data?.toEntity();
        // sending the message to firebase
        _dataSourcesContract.addMessage(
          userId: userId,
          chatId: selectedChat.toString(),
          message: ChatMessage(isBot: true, content: message?.botMessage ?? ""),
          chatTitle: message?.title ?? "",
        );
        return Success<ChatBotEntity>(data: message);
      case Error<ChatBotResponse>():
        return Error<ChatBotEntity>(exception: response.exception);
    }
  }

  @override
  Future<Result<List<ChatModel>>> getPreviousChats({
    required String userId,
  }) async {
    final response = await _dataSourcesContract.getAllChats(userId: userId);
    switch (response) {
      case Success<List<ChatModel>>():
        return Success<List<ChatModel>>(data: response.data);
      case Error<List<ChatModel>>():
        return Error<List<ChatModel>>(exception: response.exception);
    }
  }
}
