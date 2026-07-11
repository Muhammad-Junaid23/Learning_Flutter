import 'package:flutter/material.dart';
import 'package:lecture11_bottombar/Home.dart';
import 'package:lecture11_bottombar/profile.dart';
import 'package:lecture11_bottombar/settings.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  List<Widget> screenList = [
    Home(),
    Profile(),
    Settings(),
  ];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        title: Text("Bottom Bar"),
      ),
      body: screenList.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        backgroundColor: Colors.blue,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        iconSize: 30,
        onTap: (val){
          setState(() {
            selectedIndex = val;
          });
        },
        currentIndex: selectedIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: "Profile"),
          BottomNavigationBarItem(icon: Icon(Icons.settings),label: "Settings"),

        ],
      ),
    );
  }
}
