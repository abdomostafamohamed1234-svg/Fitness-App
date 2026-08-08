import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/chat_bot/data/models/responses/chat/chat_model.dart';
import 'package:flowery/features/chat_bot/domain/repo/chat_bot_repo_contract.dart';
import 'package:flowery/features/chat_bot/domain/use_cases/get_all_chats_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockChatBotRepo extends Mock implements ChatBotRepoContract {}

void main() {
  late MockChatBotRepo repo;
  late GetAllChatsUseCase useCase;

  setUp(() {
    repo = MockChatBotRepo();
    useCase = GetAllChatsUseCase(repo);
  });

  group('GetAllChatsUseCase', () {
    test('should call repository and return chats on success', () async {
      final chats = [const ChatModel(chatTitle: 'Summary', messages: [])];

      when(
        () => repo.getPreviousChats(userId: 'user-1'),
      ).thenAnswer((_) async => Success<List<ChatModel>>(data: chats));

      final result = await useCase.call(userId: 'user-1');

      expect(result, isA<Success<List<ChatModel>>>());
      expect((result as Success<List<ChatModel>>).data, chats);
      verify(() => repo.getPreviousChats(userId: 'user-1')).called(1);
    });

    test(
      'should return repository error when loading previous chats fails',
      () async {
        when(() => repo.getPreviousChats(userId: 'user-1')).thenAnswer(
          (_) async => Error<List<ChatModel>>(exception: Exception('failure')),
        );

        final result = await useCase.call(userId: 'user-1');

        expect(result, isA<Error<List<ChatModel>>>());
        expect((result as Error<List<ChatModel>>).exception, isA<Exception>());
      },
    );
  });
}
