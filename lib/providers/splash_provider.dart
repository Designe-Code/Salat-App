import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashProvider extends ChangeNotifier {
  bool _isFirstLaunch = true;

  SplashProvider() {
    _initializePrefs();
  }

  bool get isFirstLaunch => _isFirstLaunch;

  Future<void> _initializePrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

    notifyListeners();
  }

  Future<void> setFirstLaunchSeen() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isFirstLaunch', false);
    _isFirstLaunch = false;

    notifyListeners();
  }
}
