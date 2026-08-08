import 'package:bloc_test/bloc_test.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/base/base_state.dart';
import 'package:flowery/features/chat_bot/data/models/responses/chat/chat_message.dart';
import 'package:flowery/features/chat_bot/data/models/responses/chat/chat_model.dart';
import 'package:flowery/features/chat_bot/presentation/screens/chat_bot_screen.dart';
import 'package:flowery/features/chat_bot/presentation/view_model/cubit/chat_bot_cubit.dart';
import 'package:flowery/features/chat_bot/presentation/view_model/events/chat_bot_events.dart';
import 'package:flowery/features/chat_bot/presentation/view_model/state/chat_bot_state.dart';
import 'package:flowery/features/chat_bot/presentation/widgets/chat_welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockChatBotCubit extends MockCubit<ChatBotState>
    implements ChatBotCubit {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockChatBotCubit cubit;
  final baseState = const ChatBotState(
    chatsState: BaseState.success([]),
    isWelcome: true,
    selectedChatIndex: -1,
  );

  setUp(() {
    cubit = MockChatBotCubit();
    when(() => cubit.state).thenReturn(baseState);
    whenListen(cubit, Stream.value(baseState));
  });

  Widget createScreen() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider<ChatBotCubit>.value(
        value: cubit,
        child: const ChatBotScreen(
          userId: 'user-1',
          userFirstName: 'Sam',
          userImage: 'https://example.com/avatar.png',
        ),
      ),
    );
  }

  testWidgets('renders the welcome UI and start button', (tester) async {
    await tester.pumpWidget(createScreen());
    await tester.pumpAndSettle();

    expect(find.byType(ChatWelcome), findsOneWidget);
    expect(find.text('How Can I Assist You'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);
  });

  testWidgets(
    'renders chat input and user message interaction when chat state is active',
    (tester) async {
      registerFallbackValue(NavigateToChatEvent());
      final activeState = const ChatBotState(
        chatsState: BaseState.success([]),
        isWelcome: false,
        selectedChatIndex: 0,
        chats: [
          ChatModel(
            chatTitle: 'Workout Plan',
            messages: [ChatMessage(isBot: true, content: 'Hello')],
          ),
        ],
      );

      when(() => cubit.state).thenReturn(activeState);
      whenListen(cubit, Stream.value(activeState));
      when(() => cubit.doEvent(any())).thenReturn(null);

      await tester.pumpWidget(createScreen());
      await tester.pumpAndSettle();

      expect(find.text('Ask me anything about fitness...'), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'How should I train?');
      await tester.pump();

      await tester.tap(find.byIcon(Icons.send));
      await tester.pump();

      verify(
        () => cubit.doEvent(any(that: isA<SendMessageToBotEvent>())),
      ).called(1);
    },
  );
}
