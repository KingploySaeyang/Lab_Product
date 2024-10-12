import 'package:flutter/material.dart';

class AdminPageController {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void updateIndex(int newIndex) {
    _selectedIndex = newIndex;
  }
}
