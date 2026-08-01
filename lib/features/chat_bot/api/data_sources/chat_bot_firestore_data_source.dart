import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/chat_bot/data/models/responses/chat_message.dart';
import 'package:flowery/features/chat_bot/data/models/responses/chat_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ChatBotFirestoreDataSource {
  final FirebaseFirestore _firestore;

  ChatBotFirestoreDataSource(this._firestore);

  CollectionReference<Map<String, dynamic>> _chatsCollection(String userId) {
    return _firestore.collection('chat_bot').doc(userId).collection('chats');
  }

  /// Add a new chat for the user.
  Future<String> createChat({
    required String userId,
    required String title,
    required List<Map<String, dynamic>> messages,
  }) async {
    final chatRef = _chatsCollection(userId).doc();

    await chatRef.set({'title': title, 'messages': messages});

    return chatRef.id;
  }

  /// Add a message to an existing chat.
  Future<void> addMessage({
    required String userId,
    required String chatId,
    required ChatMessage message,
    required String chatTitle,
  }) async {
    final chatRef = _chatsCollection(userId).doc(chatId);

    final chatSnapshot = await chatRef.get();

    final newMessage = {'content': message.content, 'isBot': message.isBot};

    if (chatSnapshot.exists) {
      // Chat already exists → add message
      await chatRef.update({
        'title': chatTitle,
        'messages': FieldValue.arrayUnion([newMessage]),
      });
    } else {
      // Chat doesn't exist → create it
      await chatRef.set({
        'title': chatTitle,
        'messages': [newMessage],
      });
    }
  }

  /// Retrieve all chats for a specific user.
  /// Retrieve all chats for a specific user.
  Future<Result<List<ChatModel>>> getAllChats({required String userId}) async {
    final snapshot = await _chatsCollection(userId).get();
    try {
      return Success(
        data: snapshot.docs.map((doc) {
          final data = doc.data();

          final messages = (data['messages'] as List<dynamic>? ?? [])
              .map(
                (message) => ChatMessage(
                  content: message['content'] ?? '',
                  isBot: message['isBot'] ?? false,
                ),
              )
              .toList();

          return ChatModel(chatTitle: data['title'] ?? '', messages: messages);
        }).toList(),
      );
    } catch (e) {
      return Error(exception: Exception(e.toString()));
    }
  }
}
