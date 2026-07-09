import 'package:flutter/material.dart';
import 'package:lecture10_tabbar/tabbar.dart';
import 'package:lecture10_tabbar/tabbartask.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      // home: TabBarScreen(),
      home: TabBarTask(),
    );
  }
}

