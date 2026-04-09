import 'package:chat_ui/screen/home/cubit/channel_cubit.dart';
import 'package:chat_ui/screen/home/screen/messages_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChannelListScreen extends StatelessWidget {
  const ChannelListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChannelCubit, ChannelState>(
      builder: (context, state) {
        if (state is ChannelInitial) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is ChannelLoaded) {
          return Scaffold(
            appBar: AppBar(title: const Text("Channels")),
            body: ListView.builder(
              itemCount: state.channels.length,
              itemBuilder: (context, index) {
                final channel = state.channels[index];

                return ListTile(
                  selected: state.activeChannelId == channel.id,
                  title: Text("# ${channel.name}"),
                  trailing: channel.unreadCount > 0
                      ? CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.red,
                          child: Text(
                            channel.unreadCount.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        )
                      : null,
                  onTap: () {
                    context.read<ChannelCubit>().selectChannel(channel.id);
                    context.read<ChannelCubit>().markAsRead(channel.id);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const MessagesScreen()),
                    );
                  },
                );
              },
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}
