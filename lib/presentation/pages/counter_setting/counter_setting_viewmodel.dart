import 'package:flutter/material.dart';
import 'package:is_counter/database/controller/counter_controller.dart';
import 'package:is_counter/database/model/counter/counter.dart';
import 'package:is_counter/database/model/counter/counter_method.dart';
import 'package:is_counter/route/base_args.dart';

class CounterSettingViewModel extends ChangeNotifier {
  final CounterController _counterController = CounterController();
  final CounterSettingViewModelArgs _args;

  String get title => _args.counter.title;
  Counter get counter => _args.counter;

  CounterSettingViewModel(this._args) {
    _vibration = _args.counter.vibration;
  }

  late bool _vibration;
  bool get vibration => _vibration;

  void selectColor(int select) {
    counter.color = select;
    notifyListeners();
  }

  void setTitle(String title) {
    counter.title = title;
    notifyListeners();
  }

  void setMethodValue(Method method) {
    counter.counterMethod = method;
    notifyListeners();
  }

  void setVibration(bool? vibration) {
    counter.vibration = vibration ?? true;
    notifyListeners();
  }

  Future saveCounter(void Function() onFisih) async {
    await _counterController.modifyCounter(null, counter);
    onFisih();
  }
}

class CounterSettingViewModelArgs extends BaseArgs {
  final Counter counter;

  CounterSettingViewModelArgs(this.counter);
}
