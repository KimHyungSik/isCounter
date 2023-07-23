import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:is_counter/database/model/counter_list.dart';
import 'package:is_counter/database/prefs_key.dart';
import 'package:is_counter/database/sharedpreferences.dart';

import '../database/model/counter.dart';

class MainViewModel extends ChangeNotifier {
  MainViewModel() {
    getCounterList();
  }
  List<Counter> _list = [];
  List<Counter> get list => _list;
  final Prefs _prefs = Prefs();

  Future getCounterList() async {
    final listJson = await _prefs.read(PREFS_KEY.COUNTER);
    final jsonData = jsonDecode(listJson);
    _list = CounterList.fromJson(jsonData).list;
    notifyListeners();
  }

  Future setCounterList(List<Counter> list) async {
    await _prefs.save(PREFS_KEY.COUNTER, CounterList(list: list).toJson());
  }
}