import 'package:flutter/material.dart';
import 'package:lecture_gridview/grid_builder.dart';
import 'package:lecture_gridview/grid_count.dart';
import 'package:lecture_gridview/grid_staggered.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Grid View',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: GridCount(),
      // home: GridBuilder(),
      // home: GridStaggered(),
    );
  }
}
