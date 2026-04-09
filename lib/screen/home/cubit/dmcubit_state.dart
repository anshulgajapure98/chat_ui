part of 'dmcubit_cubit.dart';

@immutable
sealed class DmcubitState {}

final class DmcubitInitial extends DmcubitState {}

final class DmcubitLoaded extends DmcubitState {
  final List<UserModel> users;
  final Map<String, List<MessageModel>> directMessages;

  DmcubitLoaded({required this.users, required this.directMessages});
}
