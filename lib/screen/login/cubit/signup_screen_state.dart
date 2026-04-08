part of 'signup_screen_cubit.dart';

@immutable
sealed class SignupScreenState {}

final class SignupScreenInitial extends SignupScreenState {}

final class SignupInitial extends SignupScreenState {}

final class SignupLoading extends SignupScreenState {}

final class SignupSuccess extends SignupScreenState {}

final class SignupError extends SignupScreenState {
  final String message;

  SignupError(this.message);
}
