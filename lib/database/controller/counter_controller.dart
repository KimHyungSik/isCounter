import 'dart:convert';

import 'package:is_counter/database/model/counter/counter.dart';
import 'package:is_counter/database/model/counter/counter_list.dart';

import '../prefs/prefs_key.dart';
import '../prefs/sharedpreferences.dart';

class CounterController {
  final Prefs _prefs = Prefs();

  Future<CounterList> getCounterList() async {
    final listJson = await _prefs.read(PREFS_KEY.COUNTER);
    if (listJson == null) return CounterList();
    final jsonData = jsonDecode(listJson);

    return CounterList.fromJson(jsonData);
  }

  Future<CounterList> setCounterList(CounterList counterList) async {
    await _prefs.save(PREFS_KEY.COUNTER, counterList);
    return counterList;
  }

  Future<CounterList> modifyCounter(
    CounterList? cacheCounterList,
    Counter counter,
  ) async {
    CounterList counterList = await _checkCacheCounterList(cacheCounterList);

    int targetIndex =
        counterList.list.indexWhere((element) => element.id == counter.id);

    if (targetIndex != -1) {
      counterList.list[targetIndex] = counter;
    } else {
      counterList.list.insert(0, counter);
    }

    return await setCounterList(counterList);
  }

  Future<bool> addCounter(
    CounterList? cacheCounterList,
    Counter counter,
  ) async {
    CounterList counterList = await _checkCacheCounterList(cacheCounterList);

    int targetIndex =
        counterList.list.indexWhere((element) => element.id == counter.id);

    if (targetIndex != -1) {
      return false;
    } else {
      counterList.list.add(counter);
    }
    await setCounterList(counterList);
    return true;
  }

  Future<CounterList> removeCounter(
    CounterList? cacheCounterList,
    Counter counter,
  ) async {
    CounterList counterList = await _checkCacheCounterList(cacheCounterList);

    int targetIndex =
        counterList.list.indexWhere((element) => element.id == counter.id);

    if (targetIndex != -1) {
      counterList.list.removeAt(targetIndex);
    }
    return await setCounterList(counterList);
  }

  Future<CounterList> _checkCacheCounterList(
      CounterList? cacheCounterList) async {
    CounterList counterList;

    if (cacheCounterList != null) {
      counterList = cacheCounterList;
    } else {
      counterList = await getCounterList();
    }
    return counterList;
  }
}
