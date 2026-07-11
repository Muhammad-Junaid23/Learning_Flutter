import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:lecture12_parameters_provider/parameters/screen1.dart';
import 'package:lecture12_parameters_provider/provider/provider.dart';
import 'package:lecture12_parameters_provider/provider/screen_a.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
      MultiProvider(
        providers:[
          ChangeNotifierProvider(create: (context)=> UserProvider()),
        ],
        child : const MyApp()
      ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Parameters & Provider',
      theme: ThemeData(

        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: ScreenA(),
    );
  }
}