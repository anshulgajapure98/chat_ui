import 'package:bloc/bloc.dart';
import 'package:chat_ui/models/channel_model.dart';
import 'package:meta/meta.dart';

part 'channel_state.dart';

class ChannelCubit extends Cubit<ChannelState> {
  ChannelCubit() : super(ChannelInitial()) {
    loadChannels();
  }

  void markAsRead(String channelId) {
    if (state is ChannelLoaded) {
      final currentState = state as ChannelLoaded;

      final updatedChannels = currentState.channels.map((channel) {
        if (channel.id == channelId) {
          return channel.copyWith(unreadCount: 0);
        }
        return channel;
      }).toList();

      emit(
        ChannelLoaded(
          channels: updatedChannels,
          activeChannelId: currentState.activeChannelId,
        ),
      );
    }
  }

  void loadChannels() {
    emit(
      ChannelLoaded(
        channels: [
          ChannelModel(id: "1", name: "Local", unreadCount: 2),
          ChannelModel(id: "2", name: "random", unreadCount: 5),
          ChannelModel(id: "3", name: "Private", unreadCount: 1),
        ],
        activeChannelId: "1",
      ),
    );
  }

  void selectChannel(String channelId) {
    if (state is ChannelLoaded) {
      final currentState = state as ChannelLoaded;

      emit(
        ChannelLoaded(
          channels: currentState.channels,
          activeChannelId: channelId,
        ),
      );
    }
  }
}
