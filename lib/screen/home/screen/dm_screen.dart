import 'package:chat_ui/screen/home/cubit/dmcubit_cubit.dart';
import 'package:chat_ui/screen/home/screen/dm_chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DMScreen extends StatelessWidget {
  const DMScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DmcubitCubit, DmcubitState>(
      builder: (context, state) {
        if (state is DmcubitInitial) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is DmcubitLoaded) {
          return Scaffold(
            appBar: AppBar(title: const Text("Direct Messages")),
            body: ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                final user = state.users[index];

                return ListTile(
                  title: Text(user.name),
                  leading: const CircleAvatar(child: Icon(Icons.person)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DMChatScreen(userId: user.id),
                      ),
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
