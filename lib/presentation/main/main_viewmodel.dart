import 'dart:convert';

import 'package:flutter/material.dart';

import '../../database/controller/counter_controller.dart';
import '../../database/model/counter/counter.dart';
import '../../database/model/counter/counter_list.dart';
import '../../database/prefs/prefs_key.dart';
import '../../database/prefs/sharedpreferences.dart';

class MainViewModel extends ChangeNotifier {
  MainViewModel() {
    getCounterList();
    print("create MainViewModel");
  }
  CounterList _counterList = CounterList();
  CounterList get counterList => _counterList;
  final CounterController _counterController = CounterController();

  Future getCounterList() async {
    final counterList = await _counterController.getCounterList();
    _counterList = counterList;
    notifyListeners();
  }
}
