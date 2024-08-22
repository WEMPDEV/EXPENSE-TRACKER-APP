import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier{
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme(bool isDarkMode){
    _isDarkMode = isDarkMode;
    notifyListeners();
  }
}