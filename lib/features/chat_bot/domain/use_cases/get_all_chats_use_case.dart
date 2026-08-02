import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/chat_bot/data/models/responses/chat/chat_model.dart';
import 'package:flowery/features/chat_bot/domain/repo/chat_bot_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllChatsUseCase {
  final ChatBotRepoContract contract;
  GetAllChatsUseCase(this.contract);

  Future<Result<List<ChatModel>>> call({
    required String userId,
  }) {
    return contract.getPreviousChats(
      userId: userId,
    );
  }
}
