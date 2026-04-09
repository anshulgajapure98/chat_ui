import 'package:chat_ui/screen/home/cubit/channel_cubit.dart';
import 'package:chat_ui/screen/home/cubit/message_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return BlocBuilder<ChannelCubit, ChannelState>(
      builder: (context, channelState) {
        if (channelState is! ChannelLoaded) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final activeChannelId = channelState.activeChannelId;
        final activeChannel = channelState.channels.firstWhere(
          (e) => e.id == activeChannelId,
        );

        return BlocBuilder<MessageCubit, MessageState>(
          builder: (context, messageState) {
            if (messageState is MessageInitial) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            if (messageState is MessageLoaded) {
              final messages = messageState.messages[activeChannelId] ?? [];

              return Scaffold(
                appBar: AppBar(title: Text("# ${activeChannel.name}")),
                body: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final msg = messages[index];

                          return ListTile(
                            title: Text(msg.sender),
                            subtitle: Text(msg.content),
                            trailing: Text(
                              "${msg.timestamp.hour}:${msg.timestamp.minute}",
                            ),
                          );
                        },
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: controller,
                              decoration: const InputDecoration(
                                hintText: "Type message...",
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.send),
                            onPressed: () {
                              if (controller.text.trim().isNotEmpty) {
                                context.read<MessageCubit>().sendMessage(
                                  activeChannelId,
                                  "You",
                                  controller.text.trim(),
                                );

                                controller.clear();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }

            return const SizedBox();
          },
        );
      },
    );
  }
}
