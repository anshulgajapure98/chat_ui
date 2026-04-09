part of 'message_cubit.dart';

@immutable
sealed class MessageState {}

final class MessageInitial extends MessageState {}

final class MessageLoaded extends MessageState {
  final Map<String, List<MessageModel>> messages;

  MessageLoaded({required this.messages});
}
