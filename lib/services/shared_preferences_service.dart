import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static void saveListOfString(String key, List<String> value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(key, value);
  }

  static Future<List<String>> getListOfString(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? pagesList = prefs.getStringList(key);
    return pagesList ?? [];
  }

  static void saveInt(String key, int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, value);
  }

  static Future<int> getInt(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? pagesList = prefs.getInt(key);
    return pagesList ?? 1;
  }
}