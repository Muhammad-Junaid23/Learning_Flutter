import 'package:figmaui/app_colors.dart';
import 'package:figmaui/booking.dart';
import 'package:figmaui/home.dart';
import 'package:figmaui/profile.dart';
import 'package:figmaui/search.dart';
import 'package:flutter/material.dart';

class BottombarScreen extends StatefulWidget {
  const BottombarScreen({super.key});

  @override
  State<BottombarScreen> createState() => _BottombarScreenState();
}

class _BottombarScreenState extends State<BottombarScreen> {
  List<Widget> screenList = [
    Home(),
    Search(),
    Booking(),
    Profile(),
  ];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: screenList.elementAt(selectedIndex),
          bottomNavigationBar:
          Container(
            // 1. Add the custom drop shadow here
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08), // Shadow color and opacity
                  blurRadius: 10,                        // Softness of the shadow
                  spreadRadius: 2,                       // Extend the shadow
                  offset: const Offset(0, -4),           // Move shadow upwards (-y)
                ),
              ],
            ),
            child:
          BottomNavigationBar(
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppColors.darkGreenColor,
              unselectedItemColor: AppColors.secondaryColor,
              backgroundColor: Colors.white,
              showUnselectedLabels: true,
              showSelectedLabels: true,
              iconSize: 35,
              onTap: (val){
              setState(() {
                selectedIndex = val;
              });
              },
              currentIndex: selectedIndex,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
                BottomNavigationBarItem(icon: Icon(Icons.search),label: "Search"),
                BottomNavigationBarItem(icon: Icon(Icons.calendar_today_rounded),label: "Booking"),
                BottomNavigationBarItem(icon: Icon(Icons.person),label: "Profile"),
              ],
          ),
          ),
    );
  }
}
