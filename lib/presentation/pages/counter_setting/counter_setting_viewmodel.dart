import 'package:flutter/material.dart';
import 'package:is_counter/database/model/counter/counter.dart';

class CounterSettingViewModel extends ChangeNotifier {
  final CounterSettingViewModelArgs _args;

  String get title => _args.counter.title;

  CounterSettingViewModel(this._args);
}

class CounterSettingViewModelArgs {
  final Counter counter;

  CounterSettingViewModelArgs(this.counter);
}
