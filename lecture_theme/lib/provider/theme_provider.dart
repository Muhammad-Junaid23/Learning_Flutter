import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeMode _themeMode = ThemeMode.light;
  //set theme

  void toggleTheme(bool isDark){
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  //  get light theme
  ThemeMode get themeMode => _themeMode;

  // get dark mode
  bool get isDarkMode => _themeMode == ThemeMode.dark;

}

