import 'package:flutter/material.dart';

class AddCounterViewModel extends ChangeNotifier {
  int _selectedColor = 0;
  int get selectedColor => _selectedColor;

  void selectColor(int select) {
    _selectedColor = select;
    notifyListeners();
  }
}
