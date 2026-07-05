import 'package:flutter/material.dart';
import 'package:lecture5_pageview/pageview.dart';
import 'package:lecture5_pageview/reelsview.dart';

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
      // home: Pageview(),
      home: Reelsview(),
    );
  }
}
