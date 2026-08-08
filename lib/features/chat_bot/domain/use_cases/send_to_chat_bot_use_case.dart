import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/chat_bot/domain/entities/chat_bot_entity.dart';
import 'package:flowery/features/chat_bot/domain/repo/chat_bot_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class SendToChatBotUseCase {
  final ChatBotRepoContract contract;
  SendToChatBotUseCase(this.contract);

  Future<Result<ChatBotEntity>> call({
    required String userId,
    required int selectedChat,
    required String message,
  }) {
    return contract.sendMessageToBot(
      message: message,
      selectedChat: selectedChat,
      userId: userId,
    );
  }
}
