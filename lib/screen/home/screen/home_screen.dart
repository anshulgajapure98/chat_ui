import 'package:chat_ui/screen/home/screen/channel_list_screen.dart';
import 'package:chat_ui/screen/home/screen/dm_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  final screens = [const ChannelListScreen(), const DMScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.tag), label: "Channels"),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "DMs"),
        ],
      ),
    );
  }
}
