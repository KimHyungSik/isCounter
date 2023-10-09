import 'package:flutter/material.dart';
import 'package:is_counter/database/controller/counter_controller.dart';
import 'package:is_counter/database/model/counter/counter.dart';
import 'package:is_counter/route/base_args.dart';

class CounterViewModel extends ChangeNotifier {
  final CounterController _counterController = CounterController();
  final Counter _counter;
  Counter get counter => _counter;
  String get value => _counter.value.toString();

  CounterViewModel(this._counter);

  void incrementValue() {
    final value = _counter.value + _counter.incrementValue;
    _counter.value = value;
    _counterController.modifyCounter(null, _counter);
    notifyListeners();
  }

  void decrementValue() {
    final value = counter.value - counter.incrementValue;
    counter.value = value;
    _counterController.modifyCounter(null, counter);
    notifyListeners();
  }
}

class CounterViewModelArgs extends BaseArgs {
  final Counter counter;

  CounterViewModelArgs(this.counter);
}
