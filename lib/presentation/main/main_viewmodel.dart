import 'dart:ffi';

import 'package:flutter/material.dart';

import '../../database/controller/counter_controller.dart';
import '../../database/model/counter/counter.dart';
import '../../database/model/counter/counter_list.dart';

class MainViewModel extends ChangeNotifier {
  CounterList _counterList = CounterList();
  CounterList get counterList => _counterList;
  final CounterController _counterController = CounterController();
  MainViewModelState state = MainViewModelState.INIT;

  MainViewModel() {
    getCounterList();
  }

  Counter getCounter(String id) =>
      counterList.list.firstWhere((element) => element.id == id);

  Future getCounterList() async {
    state = MainViewModelState.LOADING;
    notifyListeners();

    final counterList = await _counterController.getCounterList();
    _counterList = counterList;
    state = MainViewModelState.REFRESH;
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
}

enum MainViewModelState { INIT, REFRESH, MODIFY, LOADING }
