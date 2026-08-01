import 'package:flowery/config/api/api_keys.dart';
import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/chat_bot/api/data_sources/chat_bot_firestore_data_source.dart';
import 'package:flowery/features/chat_bot/data/data_sources/chat_bot_remote_data_sources_contract.dart';
import 'package:flowery/features/chat_bot/data/models/requests/chat_bot_request_body.dart';
import 'package:flowery/features/chat_bot/data/models/responses/chat_bot/chat_bot_response.dart';
import 'package:flowery/features/chat_bot/data/models/responses/chat_message.dart';
import 'package:flowery/features/chat_bot/data/models/responses/chat_model.dart';
import 'package:flowery/features/chat_bot/domain/entities/chat_bot_entity.dart';
import 'package:flowery/features/chat_bot/domain/repo/chat_bot_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ChatBotRepoContract)
class ChatBotRepoImpl implements ChatBotRepoContract {
  final ChatBotFirestoreDataSource firestoreDataSource;
  final ChatBotRemoteDataSourcesContract dataSourcesContract;
  ChatBotRepoImpl(this.dataSourcesContract, this.firestoreDataSource);

  @override
  Future<Result<ChatBotEntity>> sendMessageToBot({
    required String userId,
    required int selectedChat,
    required String message,
  }) async {
    firestoreDataSource.addMessage(
      userId: userId,
      chatId: selectedChat.toString(),
      message: ChatMessage(isBot: false, content: message),
      chatTitle: "",
    );
    final response = await dataSourcesContract.sendMessageToBot(
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
        final parts = response.data?.message?.content?.split('\n');
        final title = parts?.first.trim() ?? "";
        final botMessage = parts?.skip(1).join('\n').trim();
        firestoreDataSource.addMessage(
          userId: userId,
          chatId: selectedChat.toString(),
          message: ChatMessage(isBot: true, content: botMessage ?? ""),
          chatTitle: title,
        );
        return Success<ChatBotEntity>(data: response.data?.toEntity());
      case Error<ChatBotResponse>():
        return Error<ChatBotEntity>(exception: response.exception);
    }
  }

  @override
  Future<Result<List<ChatModel>>> getPreviousChats({
    required String userId,
  }) async {
    final response = await firestoreDataSource.getAllChats(userId: userId);
    switch (response) {
      case Success<List<ChatModel>>():
        return Success<List<ChatModel>>(data: response.data);
      case Error<List<ChatModel>>():
        return Error<List<ChatModel>>(exception: response.exception);
    }
  }
}
