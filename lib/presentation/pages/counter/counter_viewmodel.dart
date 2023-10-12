import 'package:flutter/material.dart';
import 'package:is_counter/database/controller/counter_controller.dart';
import 'package:is_counter/database/model/counter/counter.dart';
import 'package:is_counter/route/base_args.dart';

class CounterViewModel extends ChangeNotifier {
  final CounterController _counterController = CounterController();
  Counter _counter;
  Counter get counter => _counter;
  String get value => _counter.value.toString();

  CounterViewModel(this._counter);

  void setNewCounter(Counter counter) {
    _counter = counter;
    notifyListeners();
  }

  void incrementValue() {
    final value = _counter.value + 1;
    _counter.value = value;
    _counterController.modifyCounter(null, _counter);
    notifyListeners();
  }

  void decrementValue() {
    final value = counter.value - 1;
    counter.value = value;
    _counterController.modifyCounter(null, counter);
    notifyListeners();
  }
}

class CounterViewModelArgs extends BaseArgs {
  final Counter counter;

  CounterViewModelArgs(this.counter);
}
