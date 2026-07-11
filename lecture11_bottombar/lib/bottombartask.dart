import 'package:flutter/material.dart';
import 'package:lecture11_bottombar/chats.dart';
import 'package:lecture11_bottombar/profile.dart';
import 'package:lecture11_bottombar/settings.dart';

class BottomBarTask extends StatefulWidget {
  const BottomBarTask({super.key});

  @override
  State<BottomBarTask> createState() => _BottomBarTaskState();
}

class _BottomBarTaskState extends State<BottomBarTask> {
  List<Widget> screenList = [
    Chats(),
    Settings(),
    Profile(),
  ];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
         body:
      screenList.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.blueGrey,
        backgroundColor: Colors.green,
        showUnselectedLabels: false,
        showSelectedLabels: true,
        iconSize: 35,
        onTap: (val){
          setState(() {
            selectedIndex = val;
          });
        },
        currentIndex: selectedIndex,
        items: [
           BottomNavigationBarItem(icon: Icon(Icons.chat_sharp),label: "Chats"),
           BottomNavigationBarItem(icon: Icon(Icons.settings_outlined),label: "Settings"),
           BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined),label: "Profile"),
          ],
      ),
    );
  }
}
