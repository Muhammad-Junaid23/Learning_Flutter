import 'package:flutter/material.dart';
import 'package:lecture_theme/provider/theme_provider.dart';
import 'package:lecture_theme/theme_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
      MultiProvider(providers: [
             ChangeNotifierProvider(create: (context)=> ThemeProvider()),
      ],
      child: const MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Themes',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeProvider.themeMode,
      home: ThemeScreen(),
    );
  }
}
