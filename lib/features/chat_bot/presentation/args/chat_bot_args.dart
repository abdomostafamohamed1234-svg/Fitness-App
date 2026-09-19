import 'package:flowery/config/api/api_keys.dart';

class ChatBotArgs {
  final String userId;
  final String userImage;
  final String userFirstName;

  const ChatBotArgs({
    this.userId = ApiKeys.userId,
    this.userImage = ApiKeys.userImage,
    this.userFirstName = ApiKeys.userFirstName,
  });
}
