import 'package:chat_ui/screen/home/cubit/dmcubit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DMChatScreen extends StatelessWidget {
  final String userId;

  DMChatScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return BlocBuilder<DmcubitCubit, DmcubitState>(
      builder: (context, state) {
        if (state is DmcubitInitial) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is DmcubitLoaded) {
          final messages = state.directMessages[userId] ?? [];
          final user = state.users.firstWhere((u) => u.id == userId);

          return Scaffold(
            appBar: AppBar(title: Text(user.name)),
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
                            hintText: "Send DM...",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {
                          if (controller.text.trim().isNotEmpty) {
                            context.read<DmcubitCubit>().sendDM(
                              userId,
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
  }
}
