import 'package:flutter/material.dart';

class QuranProvider extends ChangeNotifier{
  int currentPage = 1;
  bool isBookMarkActive = true;

  void setCurrentPage(int currentPageValue) {
    currentPage = currentPageValue;
    notifyListeners();
  }

  void setIsBookMarkActive(bool isBookMarkActiveValue) {
    isBookMarkActive = isBookMarkActiveValue;
    notifyListeners();
  }
}