part of 'channel_cubit.dart';

@immutable
sealed class ChannelState {}

final class ChannelInitial extends ChannelState {}

final class ChannelLoaded extends ChannelState {
  final List<ChannelModel> channels;
  final String activeChannelId;

  ChannelLoaded({required this.channels, required this.activeChannelId});
}
