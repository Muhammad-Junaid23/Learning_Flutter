import 'package:backend_api/provider/task_provider.dart';
import 'package:backend_api/provider/token_provider.dart';
import 'package:backend_api/provider/user_provider.dart';
import 'package:backend_api/views/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
     MultiProvider(providers:[
       ChangeNotifierProvider(create: (context)=>TokenProvider()),
       ChangeNotifierProvider(create: (context)=>UserProvider()),
       ChangeNotifierProvider(create: (_) => TaskProvider()),
     ],
         child: const MyApp()
     )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Backend API',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: LoginScreen(),
    );
  }
}