import 'package:flutter/material.dart';
import 'package:is_counter/database/controller/counter_controller.dart';
import 'package:is_counter/database/model/counter/counter.dart';
import 'package:is_counter/database/model/counter/counter_method.dart';

class CounterSettingViewModel extends ChangeNotifier {
  final CounterController _counterController = CounterController();
  final CounterSettingViewModelArgs _args;

  String get title => _args.counter.title;
  Counter get counter => _args.counter;

  CounterSettingViewModel(this._args);

  void selectColor(int select) {
    counter.color = select;
    notifyListeners();
  }

  void setTitle(String title) {
    counter.title = title;
    notifyListeners();
  }

  void setIncrementValue(int incrementValue) {
    counter.incrementValue = incrementValue;
    notifyListeners();
  }

  void setStartValue(int startValue) {
    counter.startValue = startValue;
    notifyListeners();
  }

  void setMethodValue(Method method) {
    counter.counterMethod = method;
    notifyListeners();
  }

  Future saveCounter(void Function() onFisih) async {
    await _counterController.modifyCounter(null, counter);
    onFisih();
  }
}

class CounterSettingViewModelArgs {
  final Counter counter;

  CounterSettingViewModelArgs(this.counter);
}
