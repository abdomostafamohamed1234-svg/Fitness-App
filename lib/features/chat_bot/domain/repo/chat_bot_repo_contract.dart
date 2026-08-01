import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/chat_bot/data/models/responses/chat_model.dart';
import 'package:flowery/features/chat_bot/domain/entities/chat_bot_entity.dart';

abstract interface class ChatBotRepoContract {
  Future<Result<ChatBotEntity>> sendMessageToBot({
    required String userId,
    required int selectedChat,
    required String message,
  });

  Future<Result<List<ChatModel>>> getPreviousChats({required String userId});
}
