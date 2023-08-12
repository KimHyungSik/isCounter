import 'package:flutter/material.dart';

import '../../database/controller/counter_controller.dart';
import '../../database/model/counter/counter_list.dart';

class MainViewModel extends ChangeNotifier {
  CounterList _counterList = CounterList();
  CounterList get counterList => _counterList;
  final CounterController _counterController = CounterController();

  MainViewModel() {
    getCounterList();
    print("create MainViewModel");
  }

  Future getCounterList() async {
    final counterList = await _counterController.getCounterList();
    _counterList = counterList;
    notifyListeners();
  }
}
