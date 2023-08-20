import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:is_counter/presentation/pages/main/state/main_state.dart';

import '../../../database/controller/counter_controller.dart';
import '../../../database/model/counter/counter.dart';
import '../../../database/model/counter/counter_list.dart';

class MainViewModel extends ChangeNotifier {
  CounterList get counterList => state.counterList;
  final CounterController _counterController = CounterController();
  MainState state = LoadingState();

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
}
