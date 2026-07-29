import 'package:flowery/features/chat_bot/presentation/view_model/events/chat_bot_events.dart';
import 'package:flowery/features/chat_bot/presentation/view_model/state/chat_bot_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChatBotCubit extends Cubit<ChatBotState> {
  ChatBotCubit() : super(const ChatBotState());

  void doEvent(ChatBotEvents event) {
    switch (event) {
      case NavigateToChatEvent():
        _navigateToChat();
      case SelectChatEvent():
        _selectChatEvent(event );
    }
  }

  void _selectChatEvent(SelectChatEvent event) {
    emit(state.copyWith(selectedChatIndex: event.chatIndex));
  }

  void _navigateToChat() {
    emit(state.copyWith(isWelcome: false));
  }
}
