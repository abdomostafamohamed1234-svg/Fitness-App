import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/features/chat_bot/domain/entities/chat_bot_entity.dart';
import 'package:flowery/features/chat_bot/domain/repo/chat_bot_repo_contract.dart';
import 'package:flowery/features/chat_bot/domain/use_cases/send_to_chat_bot_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockChatBotRepo extends Mock implements ChatBotRepoContract {}

void main() {
  late MockChatBotRepo repo;
  late SendToChatBotUseCase useCase;

  setUp(() {
    repo = MockChatBotRepo();
    useCase = SendToChatBotUseCase(repo);
  });

  group('SendToChatBotUseCase', () {
    test(
      'should call repository with the exact parameters and return success',
      () async {
        const expectedEntity = ChatBotEntity(
          botMessage: 'Stay consistent',
          title: 'Workout Plan',
        );

        when(
          () => repo.sendMessageToBot(
            userId: 'user-1',
            selectedChat: 2,
            message: 'How should I train?',
          ),
        ).thenAnswer(
          (_) async => const Success<ChatBotEntity>(data: expectedEntity),
        );

        final result = await useCase.call(
          userId: 'user-1',
          selectedChat: 2,
          message: 'How should I train?',
        );

        expect(result, isA<Success<ChatBotEntity>>());
        expect((result as Success<ChatBotEntity>).data, expectedEntity);
        verify(
          () => repo.sendMessageToBot(
            userId: 'user-1',
            selectedChat: 2,
            message: 'How should I train?',
          ),
        ).called(1);
      },
    );

    test('should return repository error when the repository fails', () async {
      when(
        () => repo.sendMessageToBot(
          userId: 'user-1',
          selectedChat: 1,
          message: 'How should I train?',
        ),
      ).thenAnswer(
        (_) async =>
            Error<ChatBotEntity>(exception: Exception('network failure')),
      );

      final result = await useCase.call(
        userId: 'user-1',
        selectedChat: 1,
        message: 'How should I train?',
      );

      expect(result, isA<Error<ChatBotEntity>>());
      expect((result as Error<ChatBotEntity>).exception, isA<Exception>());
    });
  });
}
