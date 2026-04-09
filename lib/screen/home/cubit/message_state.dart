part of 'message_cubit.dart';

@immutable
sealed class MessageState {}

final class MessageInitial extends MessageState {}

class MessageLoaded extends MessageState {
  final Map<String, List<MessageModel>> messages;
  final Map<String, List<MessageModel>> searchResults;

  MessageLoaded({required this.messages, this.searchResults = const {}});
}
