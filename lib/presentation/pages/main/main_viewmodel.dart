import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:is_counter/database/controller/counter_controller.dart';
import 'package:is_counter/database/model/counter/counter.dart';
import 'package:is_counter/database/model/counter/counter_list.dart';
import 'package:is_counter/presentation/pages/main/state/main_mode.dart';
import 'package:is_counter/presentation/pages/main/state/main_state.dart';

class MainViewModel extends ChangeNotifier {
  CounterList get counterList => state.counterList;
  final CounterController _counterController = CounterController();
  MainState state = LoadingState();
  MainMode _mode = MainMode.COUNTER;
  MainMode get mode => _mode;

  MainViewModel() {
    getCounterList();
  }

  Counter getCounter(String id) =>
      counterList.list.firstWhere((element) => element.id == id);

  Future getCounterList() async {
    final counterList = await _counterController.getCounterList();
    state = LoadedState(counterList);
    notifyListeners();
  }

  void incrementValue(Counter counter) {
    final value = counter.value + counter.incrementValue;
    counter.value = value;
    _counterController.modifyCounter(counterList, counter);
    notifyListeners();
  }

  void decrementValue(Counter counter) {
    final value = counter.value - counter.incrementValue;
    counter.value = value;
    _counterController.modifyCounter(counterList, counter);
    notifyListeners();
  }

  Future removeCounter(Counter counter) async {
    final newCounterList =
        await _counterController.removeCounter(counterList, counter);
    state = LoadedState(newCounterList);
    notifyListeners();
  }

  void changeMode() {
    _mode = _mode == MainMode.COUNTER ? MainMode.REMOVE : MainMode.COUNTER;
    notifyListeners();
  }

  void changeTitle(Counter counter) {
    _counterController.modifyCounter(counterList, counter);
    notifyListeners();
  }
}
