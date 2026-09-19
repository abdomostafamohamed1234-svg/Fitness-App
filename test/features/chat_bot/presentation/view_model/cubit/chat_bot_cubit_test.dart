import 'package:bloc_test/bloc_test.dart';
import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/core/base/base_state.dart';
import 'package:flowery/features/chat_bot/data/models/responses/chat/chat_message.dart';
import 'package:flowery/features/chat_bot/data/models/responses/chat/chat_model.dart';
import 'package:flowery/features/chat_bot/domain/entities/chat_bot_entity.dart';
import 'package:flowery/features/chat_bot/domain/use_cases/get_all_chats_use_case.dart';
import 'package:flowery/features/chat_bot/domain/use_cases/send_to_chat_bot_use_case.dart';
import 'package:flowery/features/chat_bot/presentation/view_model/cubit/chat_bot_cubit.dart';
import 'package:flowery/features/chat_bot/presentation/view_model/events/chat_bot_events.dart';
import 'package:flowery/features/chat_bot/presentation/view_model/state/chat_bot_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSendToChatBotUseCase extends Mock implements SendToChatBotUseCase {}

class MockGetAllChatsUseCase extends Mock implements GetAllChatsUseCase {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockSendToChatBotUseCase sendUseCase;
  late MockGetAllChatsUseCase getUseCase;

  setUp(() {
    sendUseCase = MockSendToChatBotUseCase();
    getUseCase = MockGetAllChatsUseCase();
  });

  group('Initial State', () {
    test('should start with the default chat bot state', () {
      final cubit = ChatBotCubit(sendUseCase, getUseCase);
      expect(cubit.state, const ChatBotState());
      cubit.close();
    });
  });

  group('Success Cases', () {
    blocTest<ChatBotCubit, ChatBotState>(
      'emits loading then success when get previous chats succeeds',
      build: () {
        when(() => getUseCase.call(userId: 'user-1')).thenAnswer(
          (_) async => const Success<List<ChatModel>>(
            data: [
              ChatModel(
                chatTitle: 'Existing Chat',
                messages: [ChatMessage(isBot: true, content: 'Old response')],
              ),
            ],
          ),
        );
        return ChatBotCubit(sendUseCase, getUseCase);
      },
      act: (cubit) => cubit.doEvent(GetPreviousChatsEvent(userId: 'user-1')),
      expect: () => [
        isA<ChatBotState>().having(
          (state) => state.chatsState.state,
          'chatsState.state',
          StateType.loading,
        ),
        isA<ChatBotState>()
            .having(
              (state) => state.chatsState.state,
              'chatsState.state',
              StateType.success,
            )
            .having(
              (state) => state.chats?.first.chatTitle,
              'chatTitle',
              'Existing Chat',
            ),
      ],
      verify: (_) {
        verify(() => getUseCase.call(userId: 'user-1')).called(1);
      },
    );

    blocTest<ChatBotCubit, ChatBotState>(
      'selects a chat and updates selectedChatIndex',
      build: () => ChatBotCubit(sendUseCase, getUseCase),
      act: (cubit) => cubit.doEvent(SelectChatEvent(chatIndex: 2)),
      expect: () => [
        isA<ChatBotState>().having(
          (state) => state.selectedChatIndex,
          'selectedChatIndex',
          2,
        ),
      ],
    );

    blocTest<ChatBotCubit, ChatBotState>(
      'navigates away from welcome state',
      build: () => ChatBotCubit(sendUseCase, getUseCase),
      act: (cubit) => cubit.doEvent(NavigateToChatEvent()),
      expect: () => [
        isA<ChatBotState>().having(
          (state) => state.isWelcome,
          'isWelcome',
          false,
        ),
      ],
    );

    blocTest<ChatBotCubit, ChatBotState>(
      'creates a new chat and appends bot reply when send success happens',
      build: () {
        when(
          () => sendUseCase.call(
            userId: 'user-1',
            selectedChat: 0,
            message: 'How to train?',
          ),
        ).thenAnswer(
          (_) async => const Success<ChatBotEntity>(
            data: ChatBotEntity(
              botMessage: 'Train with consistency',
              title: 'New Chat',
            ),
          ),
        );
        return ChatBotCubit(sendUseCase, getUseCase);
      },
      act: (cubit) => cubit.doEvent(
        SendMessageToBotEvent(
          userId: 'user-1',
          message: 'How to train?',
          messageOffset: 120,
        ),
      ),
      expect: () => [
        isA<ChatBotState>().having(
          (state) => state.chatBotState.state,
          'chatBotState.state',
          StateType.loading,
        ),
        isA<ChatBotState>()
            .having((state) => state.selectedChatIndex, 'selectedChatIndex', 0)
            .having((state) => state.messageOffset, 'messageOffset', 120),
        isA<ChatBotState>()
            .having(
              (state) => state.chatBotState.state,
              'chatBotState.state',
              StateType.success,
            )
            .having(
              (state) => state.chats?.first.messages.last.content,
              'bot reply',
              'Train with consistency',
            ),
      ],
      verify: (_) {
        verify(
          () => sendUseCase.call(
            userId: 'user-1',
            selectedChat: 0,
            message: 'How to train?',
          ),
        ).called(1);
      },
    );
  });

  group('Error Cases', () {
    blocTest<ChatBotCubit, ChatBotState>(
      'emits error state when previous chats request fails',
      build: () {
        when(() => getUseCase.call(userId: 'user-1')).thenAnswer(
          (_) async => Error<List<ChatModel>>(exception: Exception('boom')),
        );
        return ChatBotCubit(sendUseCase, getUseCase);
      },
      act: (cubit) => cubit.doEvent(GetPreviousChatsEvent(userId: 'user-1')),
      expect: () => [
        isA<ChatBotState>().having(
          (state) => state.chatsState.state,
          'chatsState.state',
          StateType.loading,
        ),
        isA<ChatBotState>().having(
          (state) => state.chatsState.state,
          'chatsState.state',
          StateType.error,
        ),
      ],
    );

    blocTest<ChatBotCubit, ChatBotState>(
      'emits error state when send use case fails',
      build: () {
        when(
          () => sendUseCase.call(
            userId: 'user-1',
            selectedChat: 0,
            message: 'How to train?',
          ),
        ).thenAnswer(
          (_) async =>
              Error<ChatBotEntity>(exception: Exception('send failed')),
        );
        return ChatBotCubit(sendUseCase, getUseCase);
      },
      act: (cubit) => cubit.doEvent(
        SendMessageToBotEvent(
          userId: 'user-1',
          message: 'How to train?',
          messageOffset: 120,
        ),
      ),
      
      expect: () => [
        const ChatBotState(chatBotState: BaseState.loading()),
        const ChatBotState(
          chatBotState: BaseState.loading(),
          chats: [
            ChatModel(
              chatTitle: 'New Chat',
              messages: [ChatMessage(isBot: false, content: 'How to train?')],
            ),
          ],
          selectedChatIndex: 0,
          messageOffset: 120,
        ),
        ChatBotState(
          chatBotState: BaseState.error(Exception('send failed')),
          chats: [
            const ChatModel(
              chatTitle: 'New Chat',
              messages: [ChatMessage(isBot: false, content: 'How to train?')],
            ),
          ],
          selectedChatIndex: 0,
          messageOffset: 120,
        ),
      ],
    );
  });

  group('Edge Cases', () {
    test(
      'keeps loading state after send event when bot response is pending',
      () async {
        final cubit = ChatBotCubit(sendUseCase, getUseCase);
        when(
          () => sendUseCase.call(
            userId: 'user-1',
            selectedChat: 0,
            message: 'How to train?',
          ),
        ).thenAnswer(
          (_) async => Future.delayed(
            const Duration(milliseconds: 10),
            () => const Success<ChatBotEntity>(
              data: ChatBotEntity(
                botMessage: 'Train with consistency',
                title: 'New Chat',
              ),
            ),
          ),
        );

        cubit.doEvent(
          SendMessageToBotEvent(
            userId: 'user-1',
            message: 'How to train?',
            messageOffset: 130,
          ),
        );

        expect(cubit.state.chatBotState.state, StateType.loading);
        await Future<void>.delayed(const Duration(milliseconds: 20));
        cubit.close();
      },
    );
  });
}
