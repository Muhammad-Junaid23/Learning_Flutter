import 'package:flutter/material.dart';
import 'package:lecture4_textfields/loginUI.dart';
import 'package:lecture4_textfields/registerUI.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Learning',
      theme: ThemeData(

        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      // home: LoginUI(),
      home: RegisterUI(),
    );
  }
}
