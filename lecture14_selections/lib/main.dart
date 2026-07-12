import 'package:flutter/material.dart';
import 'package:lecture14_selections/selection_form.dart';
import 'package:lecture14_selections/selections/multiple.dart';
import 'package:lecture14_selections/selections/single.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Single & Multiple Selections',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      // home: SingleSelection(),
      // home: MultipleSelection(),
      home: SelectionForm(),
    );
  }
}