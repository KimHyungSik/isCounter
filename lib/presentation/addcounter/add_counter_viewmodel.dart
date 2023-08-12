import 'package:flutter/material.dart';
import 'package:is_counter/database/controller/counter_controller.dart';
import 'package:uuid/uuid.dart';

import '../../database/model/counter/counter.dart';
import '../../database/model/counter/counter_method.dart';

class AddCounterViewModel extends ChangeNotifier {
  CounterController _counterController = CounterController();

  String _title = "카운터";
  String get title => _title;

  int _startValue = 0;
  int get startValue => _startValue;

  int _incrementValue = 1;
  int get incrementValue => _incrementValue;

  int _selectedColor = 0;
  int get selectedColor => _selectedColor;

  Method _method = Method.BUTTON;
  Method get method => _method;

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

  void setMethodValue(Method method) {
    _method = method;
    notifyListeners();
  }

  Future<bool> saveCounter() async {
    Counter counter = Counter(
        id: const Uuid().v4(),
        title: title,
        color: selectedColor,
        value: startValue,
        startValue: startValue,
        incrementValue: incrementValue,
        counterMethod: Method.BUTTON);

    return await _counterController.addCounter(null, counter);
  }
}
