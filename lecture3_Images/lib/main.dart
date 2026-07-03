import 'package:flutter/material.dart';
import 'package:lecture3_images/assetImages.dart';
import 'package:lecture3_images/images.dart';
import 'package:lecture3_images/networkImages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lecture 3 Images',
      theme: ThemeData(

        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      // home: Images(),
      // home: AssetImages(),
      home: NetworkImages(),
    );
  }
}
