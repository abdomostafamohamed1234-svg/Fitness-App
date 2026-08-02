import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flowery/config/api/api_keys.dart';
import 'package:flowery/config/exception_handlers/dio_exception_handler.dart';
import 'package:flowery/config/exception_handlers/firebase_exception_handler.dart';
import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/chat_bot/api/api_client/chat_bot_api_client.dart';
import 'package:flowery/features/chat_bot/data/data_sources/chat_bot_remote_data_sources_contract.dart';
import 'package:flowery/features/chat_bot/data/models/requests/chat_bot_request_body.dart';
import 'package:flowery/features/chat_bot/data/models/responses/chat/chat_message.dart';
import 'package:flowery/features/chat_bot/data/models/responses/chat/chat_model.dart';
import 'package:flowery/features/chat_bot/data/models/responses/chat_bot/chat_bot_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ChatBotRemoteDataSourcesContract)
class ChatBotRemoteDataSourcesImpl implements ChatBotRemoteDataSourcesContract {
  final ChatBotApiClient _chatBotApiClient;
  final FirebaseFirestore _firestore;
  ChatBotRemoteDataSourcesImpl(this._chatBotApiClient, this._firestore);

  @override
  Future<Result<ChatBotResponse>> sendMessageToBot({
    required ChatBotRequestBody body,
  }) async {
    try {
      final response = await _chatBotApiClient.sendMessageToBot(body: body);
      return Success<ChatBotResponse>(data: response);
    } on DioException catch (e) {
      return Error<ChatBotResponse>(
        exception: await DioExceptionHandler.handle(e),
      );
    }
  }

  CollectionReference<Map<String, dynamic>> _chatsCollection(String userId) {
    return _firestore
        .collection(ApiKeys.chatBotCollectionName)
        .doc(userId)
        .collection(ApiKeys.chatBotChats);
  }

  @override
  Future<Result<void>> addMessage({
    required String userId,
    required String chatId,
    required ChatMessage message,
    required String chatTitle,
  }) async {
    try {
      final chatRef = _chatsCollection(userId).doc(chatId);

      final chatSnapshot = await chatRef.get();

      if (chatSnapshot.exists) {
        // Append the message to an already existing chat
        await chatRef.update({
          ApiKeys.title: chatTitle,
          ApiKeys.messages: FieldValue.arrayUnion([message.toJson()]),
        });
      } else {
        // Add the message to a new chat
        await chatRef.set({
          ApiKeys.title: chatTitle,
          ApiKeys.messages: [message.toJson()],
        });
      }
      return const Success();
    } on FirebaseException catch (e) {
      return Error(exception: await FirebaseExceptionHandler.handle(e));
    }
  }

  @override
  Future<Result<List<ChatModel>>> getAllChats({required String userId}) async {
    final snapshot = await _chatsCollection(userId).get();
    try {
      return Success(
        data: snapshot.docs.map((doc) {
          final data = doc.data();

          final messages =
              (data[ApiKeys.messages] as List?)
                  ?.map((message) => ChatMessage.fromJson(message))
                  .toList() ??
              [];

          return ChatModel(
            chatTitle: data[ApiKeys.title] ?? '',
            messages: messages,
          );
        }).toList(),
      );
    } on FirebaseException catch (e) {
      return Error(exception: await FirebaseExceptionHandler.handle(e));
    }
  }
}
