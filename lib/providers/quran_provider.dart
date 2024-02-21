import 'package:flutter/material.dart';

class QuranProvider extends ChangeNotifier{
  String currentTab = 'Surah';

  void setCurrentTab(String currentTabValue) {
    currentTab = currentTabValue;
    notifyListeners();
  }
}