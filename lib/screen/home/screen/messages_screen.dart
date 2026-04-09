import 'package:chat_ui/screen/home/cubit/channel_cubit.dart';
import 'package:chat_ui/screen/home/cubit/message_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    final TextEditingController searchController = TextEditingController();

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
              final messagesToShow =
                  messageState.searchResults[activeChannelId]?.isNotEmpty ==
                      true
                  ? messageState.searchResults[activeChannelId]!
                  : messages;
              return Scaffold(
                appBar: AppBar(title: Text("# ${activeChannel.name}")),
                body: Column(
                  children: [
                    TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        hintText: "Search messages...",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        context.read<MessageCubit>().searchMessages(
                          activeChannelId,
                          value,
                        );
                      },
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: messagesToShow.length,
                        itemBuilder: (context, index) {
                          final msg = messagesToShow[index];

                          final text = msg.content;
                          final keyword = searchController.text.trim();

                          return ListTile(
                            title: Text(msg.sender),
                            subtitle: keyword.isNotEmpty
                                ? RichText(
                                    text: TextSpan(
                                      text: "",
                                      style: DefaultTextStyle.of(context).style,
                                      children: _highlightKeyword(
                                        text,
                                        keyword,
                                      ),
                                    ),
                                  )
                                : Text(msg.content),
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

  List<TextSpan> _highlightKeyword(String text, String keyword) {
    final matches = RegExp(
      RegExp.escape(keyword),
      caseSensitive: false,
    ).allMatches(text);
    if (matches.isEmpty) return [TextSpan(text: text)];

    List<TextSpan> spans = [];
    int lastIndex = 0;

    for (final m in matches) {
      if (m.start > lastIndex)
        spans.add(TextSpan(text: text.substring(lastIndex, m.start)));
      spans.add(
        TextSpan(
          text: text.substring(m.start, m.end),
          style: const TextStyle(backgroundColor: Colors.yellow),
        ),
      );
      lastIndex = m.end;
    }

    if (lastIndex < text.length)
      spans.add(TextSpan(text: text.substring(lastIndex)));

    return spans;
  }
}
