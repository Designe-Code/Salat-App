import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper/theme.dart';

class ThemeProvider with ChangeNotifier {
  ThemeProvider() {
    _loadThemeFromPreferences();
  }

  bool _isDarkModeEnabled = false;
  late ThemeData _themeData = lightTheme;

  ThemeData get themeData => _themeData;

  void toggleTheme() {
    _isDarkModeEnabled = !_isDarkModeEnabled;
    _saveThemeToPreferences();
    _themeData = _isDarkModeEnabled ? darkMode : lightTheme;
    notifyListeners();
  }

  Future<void> _loadThemeFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkModeEnabled = prefs.getBool('isDarkModeEnabled') ?? false;
    _themeData = _isDarkModeEnabled ? darkMode : lightTheme;
    notifyListeners();
  }

  Future<void> _saveThemeToPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkModeEnabled', _isDarkModeEnabled);
  }
}
