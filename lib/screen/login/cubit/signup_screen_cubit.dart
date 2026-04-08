import 'package:bloc/bloc.dart';
import 'package:chat_ui/local_storage.dart';
import 'package:meta/meta.dart';

part 'signup_screen_state.dart';

class SignupScreenCubit extends Cubit<SignupScreenState> {
  SignupScreenCubit() : super(SignupScreenInitial());
  final LocalStorage _storage = LocalStorage();

  void signup(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      emit(SignupError("All fields required"));
      return;
    }

    emit(SignupLoading());

    await Future.delayed(const Duration(seconds: 1));

    await _storage.saveUser(email, password);

    emit(SignupSuccess());
  }
}
