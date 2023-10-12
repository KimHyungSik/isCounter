import 'package:flutter/material.dart';
import 'package:is_counter/database/controller/counter_controller.dart';
import 'package:is_counter/route/base_args.dart';
import 'package:uuid/uuid.dart';

import '../../../common/localization.dart';
import '../../../database/model/counter/counter.dart';
import '../../../database/model/counter/counter_method.dart';

class AddCounterViewModel extends ChangeNotifier {
  final String? titleCounter;
  final CounterController _counterController = CounterController();

  AddCounterViewModel(this.titleCounter) {
    _title = "${string(Localize.counter)} $titleCounter";
  }

  String _title = "";

  String get title => _title;

  int _selectedColor = 0;
  int get selectedColor => _selectedColor;

  Method _method = Method.BUTTON;
  Method get method => _method;

  bool _vibration = true;
  bool get vibration => _vibration;

  void selectColor(int select) {
    _selectedColor = select;
    notifyListeners();
  }

  void setTitle(String title) {
    _title = title;
    notifyListeners();
  }

  void setMethodValue(Method method) {
    _method = method;
    notifyListeners();
  }

  void setVibration(bool? vibration) {
    _vibration = vibration ?? true;
    notifyListeners();
  }

  Future<bool> saveCounter() async {
    Counter counter = Counter(
        id: const Uuid().v4(),
        title: title,
        color: selectedColor,
        value: 0,
        vibration: vibration,
        counterMethod: _method);

    return await _counterController.addCounter(null, counter);
  }
}

class AddCounterViewModelArgs extends BaseArgs {
  final String? titleCounter;

  AddCounterViewModelArgs(this.titleCounter);
}
