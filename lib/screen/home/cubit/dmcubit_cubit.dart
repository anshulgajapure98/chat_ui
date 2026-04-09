import 'package:bloc/bloc.dart';
import 'package:chat_ui/models/message_model.dart';
import 'package:chat_ui/models/user_model.dart';
import 'package:meta/meta.dart';

part 'dmcubit_state.dart';

class DmcubitCubit extends Cubit<DmcubitState> {
  DmcubitCubit() : super(DmcubitInitial()) {
    loadUsers();
  }

  void loadUsers() {
    emit(
      DmcubitLoaded(
        users: [
          UserModel(id: "1", name: "Rahul"),
          UserModel(id: "2", name: "Priya"),
          UserModel(id: "3", name: "Amit"),
        ],
        directMessages: {},
      ),
    );
  }

  void sendDM(String userId, String sender, String text) {
    if (state is DmcubitLoaded) {
      final currentState = state as DmcubitLoaded;

      final updatedDMs = Map<String, List<MessageModel>>.from(
        currentState.directMessages,
      );

      updatedDMs.putIfAbsent(userId, () => []);

      updatedDMs[userId]!.add(
        MessageModel(sender: sender, content: text, timestamp: DateTime.now()),
      );

      emit(
        DmcubitLoaded(users: currentState.users, directMessages: updatedDMs),
      );
    }
  }
}
