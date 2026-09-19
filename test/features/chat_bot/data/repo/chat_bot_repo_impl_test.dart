import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/chat_bot/data/data_sources/chat_bot_remote_data_sources_contract.dart';
import 'package:flowery/features/chat_bot/data/models/requests/chat_bot_request_body.dart';
import 'package:flowery/features/chat_bot/data/models/responses/chat/chat_message.dart';
import 'package:flowery/features/chat_bot/data/models/responses/chat/chat_model.dart';
import 'package:flowery/features/chat_bot/data/models/responses/chat_bot/chat_bot_response.dart';
import 'package:flowery/features/chat_bot/data/repo/chat_bot_repo_impl.dart';
import 'package:flowery/features/chat_bot/domain/entities/chat_bot_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockChatBotRemoteDataSource extends Mock
    implements ChatBotRemoteDataSourcesContract {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  registerFallbackValue(ChatBotRequestBody());

  late MockChatBotRemoteDataSource remoteDataSource;
  late ChatBotRepoImpl repo;

  setUp(() {
    remoteDataSource = MockChatBotRemoteDataSource();
    repo = ChatBotRepoImpl(remoteDataSource);
  });

  group('ChatBotRepoImpl', () {
    test(
      'returns mapped ChatBotEntity and stores user and bot messages on success',
      () async {
        registerFallbackValue(const ChatMessage(isBot: false, content: ''));
        final response = ChatBotResponse(
          message: Message(content: 'Workout Plan\nTrain with consistency'),
        );

        when(
          () => remoteDataSource.addMessage(
            userId: any(named: 'userId'),
            chatId: any(named: 'chatId'),
            message: any(named: 'message'),
            chatTitle: any(named: 'chatTitle'),
          ),
        ).thenAnswer((_) async => const Success<void>());

        when(
          () => remoteDataSource.sendMessageToBot(body: any(named: 'body')),
        ).thenAnswer((_) async => Success<ChatBotResponse>(data: response));

        final result = await repo.sendMessageToBot(
          userId: 'user-1',
          selectedChat: 0,
          message: 'How should I train?',
        );

        expect(result, isA<Success<ChatBotEntity>>());
        expect(
          (result as Success<ChatBotEntity>).data,
          const ChatBotEntity(
            botMessage: 'Train with consistency',
            title: 'Workout Plan',
          ),
        );

        verify(
          () => remoteDataSource.addMessage(
            userId: 'user-1',
            chatId: '0',
            message: const ChatMessage(
              isBot: false,
              content: 'How should I train?',
            ),
            chatTitle: '',
          ),
        ).called(1);

        verify(
          () => remoteDataSource.addMessage(
            userId: 'user-1',
            chatId: '0',
            message: const ChatMessage(
              isBot: true,
              content: 'Train with consistency',
            ),
            chatTitle: 'Workout Plan',
          ),
        ).called(1);
      },
    );

    test('returns Error when remote bot request fails', () async {
      registerFallbackValue(const ChatMessage(isBot: false, content: ''));
      when(
        () => remoteDataSource.addMessage(
          userId: any(named: 'userId'),
          chatId: any(named: 'chatId'),
          message: any(named: 'message'),
          chatTitle: any(named: 'chatTitle'),
        ),
      ).thenAnswer((_) async => const Success<void>());

      when(
        () => remoteDataSource.sendMessageToBot(body: any(named: 'body')),
      ).thenAnswer(
        (_) async => Error<ChatBotResponse>(exception: Exception('api failed')),
      );

      final result = await repo.sendMessageToBot(
        userId: 'user-1',
        selectedChat: 0,
        message: 'How should I train?',
      );

      expect(result, isA<Error<ChatBotEntity>>());
      expect((result as Error<ChatBotEntity>).exception, isA<Exception>());
    });

    test('returns previous chats on success', () async {
      final chats = [const ChatModel(chatTitle: 'Workout Plan', messages: [])];

      when(
        () => remoteDataSource.getAllChats(userId: 'user-1'),
      ).thenAnswer((_) async => Success<List<ChatModel>>(data: chats));

      final result = await repo.getPreviousChats(userId: 'user-1');

      expect(result, isA<Success<List<ChatModel>>>());
      expect((result as Success<List<ChatModel>>).data, chats);
      verify(() => remoteDataSource.getAllChats(userId: 'user-1')).called(1);
    });

    test('returns repository error when previous chats fetch fails', () async {
      when(() => remoteDataSource.getAllChats(userId: 'user-1')).thenAnswer(
        (_) async =>
            Error<List<ChatModel>>(exception: Exception('firebase issue')),
      );

      final result = await repo.getPreviousChats(userId: 'user-1');

      expect(result, isA<Error<List<ChatModel>>>());
      expect((result as Error<List<ChatModel>>).exception, isA<Exception>());
    });
  });
}
