import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flowery/config/api/api_keys.dart';
import 'package:flowery/config/di/di_config.dart';
import 'package:flowery/config/exception_handlers/app_exception.dart';
import 'package:flowery/config/helpers/shared_preferences/shared_preferences_helper.dart';
import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/chat_bot/api/api_client/chat_bot_api_client.dart';
import 'package:flowery/features/chat_bot/api/data_sources/chat_bot_remote_data_sources_impl.dart';
import 'package:flowery/features/chat_bot/data/models/requests/chat_bot_request_body.dart';
import 'package:flowery/features/chat_bot/data/models/responses/chat/chat_message.dart';
import 'package:flowery/features/chat_bot/data/models/responses/chat/chat_model.dart';
import 'package:flowery/features/chat_bot/data/models/responses/chat_bot/chat_bot_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockChatBotApiClient extends Mock implements ChatBotApiClient {}

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

// ignore: subtype_of_sealed_class
class MockCollectionReference extends Mock
    implements CollectionReference<Map<String, dynamic>> {}

// ignore: subtype_of_sealed_class
class MockDocumentReference extends Mock
    implements DocumentReference<Map<String, dynamic>> {}

// ignore: subtype_of_sealed_class
class MockDocumentSnapshot extends Mock
    implements DocumentSnapshot<Map<String, dynamic>> {}

class MockQuerySnapshot extends Mock
    implements QuerySnapshot<Map<String, dynamic>> {}

// ignore: subtype_of_sealed_class
class MockQueryDocumentSnapshot extends Mock
    implements QueryDocumentSnapshot<Map<String, dynamic>> {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    getIt.reset();
    SharedPreferences.setMockInitialValues({});
    final sharedPreferences = await SharedPreferences.getInstance();
    getIt.registerSingleton<SharedPreferencesHelper>(
      SharedPreferencesHelper(sharedPreferences),
    );
  });

  tearDown(() => getIt.reset());

  group('ChatBotRemoteDataSourcesImpl', () {
    test('returns chat bot response from ApiClient on success', () async {
      final apiClient = MockChatBotApiClient();
      final firestore = MockFirebaseFirestore();
      final dataSource = ChatBotRemoteDataSourcesImpl(apiClient, firestore);
      final body = ChatBotRequestBody(
        model: ApiKeys.modelType,
        stream: false,
        messages: [ClientMessage(role: ApiKeys.user, content: 'hello')],
      );

      final response = ChatBotResponse(
        message: Message(content: 'Workout Plan\nTrain with consistency'),
      );

      when(
        () => apiClient.sendMessageToBot(body: body),
      ).thenAnswer((_) async => response);

      final result = await dataSource.sendMessageToBot(body: body);

      expect(result, isA<Success<ChatBotResponse>>());
      expect((result as Success<ChatBotResponse>).data, response);
      verify(() => apiClient.sendMessageToBot(body: body)).called(1);
    });

    test('returns error result when API client throws DioException', () async {
      final apiClient = MockChatBotApiClient();
      final firestore = MockFirebaseFirestore();
      final dataSource = ChatBotRemoteDataSourcesImpl(apiClient, firestore);
      final body = ChatBotRequestBody();

      when(
        () => apiClient.sendMessageToBot(body: body),
      ).thenThrow(DioException(requestOptions: RequestOptions(path: '/chat')));

      final result = await dataSource.sendMessageToBot(body: body);

      expect(result, isA<Error<ChatBotResponse>>());
      expect((result as Error<ChatBotResponse>).exception, isA<AppException>());
    });

    test(
      'adds a new message document and stores chat title to Firestore',
      () async {
        final apiClient = MockChatBotApiClient();
        final firestore = MockFirebaseFirestore();
        final chatsCollection = MockCollectionReference();
        final chatDoc = MockDocumentReference();
        final chatSnapshot = MockDocumentSnapshot();
        final dataSource = ChatBotRemoteDataSourcesImpl(apiClient, firestore);

        when(
          () => firestore.collection(ApiKeys.chatBotCollectionName),
        ).thenReturn(chatsCollection);
        when(() => chatsCollection.doc('user-1')).thenReturn(chatDoc);
        when(
          () => chatDoc.collection(ApiKeys.chatBotChats),
        ).thenReturn(chatsCollection);
        when(() => chatsCollection.doc('1')).thenReturn(chatDoc);
        when(() => chatDoc.get()).thenAnswer((_) async => chatSnapshot);
        when(() => chatSnapshot.exists).thenReturn(false);
        when(() => chatDoc.set(any())).thenAnswer((_) async {});

        final result = await dataSource.addMessage(
          userId: 'user-1',
          chatId: '1',
          message: const ChatMessage(
            isBot: false,
            content: 'How should I train?',
          ),
          chatTitle: 'Workout Plan',
        );

        expect(result, isA<Success<void>>());
        verify(() => chatDoc.set(any())).called(1);
      },
    );

    test('returns mapped chat models from Firestore', () async {
      final apiClient = MockChatBotApiClient();
      final firestore = MockFirebaseFirestore();
      final chatsCollection = MockCollectionReference();
      final chatDoc = MockDocumentReference();
      final querySnapshot = MockQuerySnapshot();
      final queryDocumentSnapshot = MockQueryDocumentSnapshot();
      final dataSource = ChatBotRemoteDataSourcesImpl(apiClient, firestore);

      when(
        () => firestore.collection(ApiKeys.chatBotCollectionName),
      ).thenReturn(chatsCollection);
      when(() => chatsCollection.doc('user-1')).thenReturn(chatDoc);
      when(
        () => chatDoc.collection(ApiKeys.chatBotChats),
      ).thenReturn(chatsCollection);
      when(() => chatsCollection.get()).thenAnswer((_) async => querySnapshot);
      when(() => querySnapshot.docs).thenReturn([queryDocumentSnapshot]);
      when(() => queryDocumentSnapshot.data()).thenReturn({
        ApiKeys.title: 'Workout Plan',
        ApiKeys.messages: [
          const ChatMessage(
            isBot: false,
            content: 'How should I train?',
          ).toJson(),
        ],
      });

      final result = await dataSource.getAllChats(userId: 'user-1');

      expect(result, isA<Success<List<ChatModel>>>());
      final chats = (result as Success<List<ChatModel>>).data;
      expect(chats, hasLength(1));
      expect(chats?.first.chatTitle, 'Workout Plan');
      expect(chats?.first.messages.first.content, 'How should I train?');
      expect(chats?.first.messages.first.isBot, isFalse);
    });
  });
}
