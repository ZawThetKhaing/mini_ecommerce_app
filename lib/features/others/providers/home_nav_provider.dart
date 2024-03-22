import 'package:flutter/material.dart';

class HomeNavProvider extends ChangeNotifier {
  HomeNavProvider();

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void changeBottomNav(int value) {
    _currentIndex = value;
    notifyListeners();
  }
}
