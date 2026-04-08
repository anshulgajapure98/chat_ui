import 'package:bloc/bloc.dart';
import 'package:chat_ui/local_storage.dart';
import 'package:meta/meta.dart';

part 'login_screen_state.dart';

class LoginScreenCubit extends Cubit<LoginScreenState> {
  LoginScreenCubit() : super(LoginScreenInitial());

  final LocalStorage _storage = LocalStorage();
  
  void login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      emit(AuthError("All fields are required"));
      return;
    }

    emit(AuthLoading());

    final user = await _storage.getUser();

    if (email == user["email"] && password == user["password"]) {
      await _storage.setLoggedIn(true);
      emit(AuthSuccess());
    } else {
      emit(AuthError("Invalid email or password"));
    }
  }
}
