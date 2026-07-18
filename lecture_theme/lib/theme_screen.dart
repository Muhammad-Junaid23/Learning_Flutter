import 'package:flutter/material.dart';
import 'package:lecture_theme/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({super.key});

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Theme Selection"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          children: [
            Text("Change theme from here",style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w900,
            ),
            ),
            Icon(Icons.access_alarm,size: 40,),
            Switch(value: themeProvider.isDarkMode,
                onChanged: (value){
              themeProvider.toggleTheme(value);
                }
            ),
          ],
        ),
      ),
    );
  }
}
