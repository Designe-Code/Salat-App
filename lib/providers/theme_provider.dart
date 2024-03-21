import 'package:flutter/material.dart';
import 'package:salati/helper/theme.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;
  ThemeData _themeData = lightTheme;

  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    if (_isDarkMode) {
      themeData = darkMode;
    } else {
      themeData = lightTheme;
    }
  }
}
