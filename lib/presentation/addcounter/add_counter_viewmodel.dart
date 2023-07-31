import 'package:flutter/material.dart';

class AddCounterViewModel extends ChangeNotifier {
  String _title = "카운터";
  String get title => _title;

  int _startValue = 0;
  int get startValue => _startValue;

  int _incrementValue = 1;
  int get incrementValue => _incrementValue;

  int _selectedColor = 0;
  int get selectedColor => _selectedColor;

  void selectColor(int select) {
    _selectedColor = select;
    notifyListeners();
  }

  void setTitle(String title) {
    _title = title;
    notifyListeners();
  }

  void setIncrementValue(int incrementValue) {
    _incrementValue = incrementValue;
    notifyListeners();
  }

  void setStartValue(int startValue) {
    _startValue = startValue;
    notifyListeners();
  }
}
