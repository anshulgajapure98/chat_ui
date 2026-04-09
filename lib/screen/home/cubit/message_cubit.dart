import 'package:bloc/bloc.dart';
import 'package:chat_ui/models/message_model.dart';
import 'package:meta/meta.dart';

part 'message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  MessageCubit() : super(MessageInitial()) {
    loadMessages();
  }

  void loadMessages() {
    emit(MessageLoaded(messages: {"1": [], "2": [], "3": []}));
  }

  void sendMessage(String channelId, String sender, String text) {
    if (state is MessageLoaded) {
      final currentState = state as MessageLoaded;

      final updatedMessages = Map<String, List<MessageModel>>.from(
        currentState.messages,
      );

      updatedMessages[channelId] = [
        ...updatedMessages[channelId]!,
        MessageModel(sender: sender, content: text, timestamp: DateTime.now()),
      ];

      emit(MessageLoaded(messages: updatedMessages));
    }
  }
}
