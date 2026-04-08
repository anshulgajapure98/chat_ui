part of 'login_screen_cubit.dart';

@immutable
sealed class LoginScreenState {}

final class LoginScreenInitial extends LoginScreenState {}

final class AuthInitial extends LoginScreenState {}

final class AuthLoading extends LoginScreenState {}

final class AuthSuccess extends LoginScreenState {}

final class AuthError extends LoginScreenState {
  final String message;

  AuthError(this.message);
}
