import 'package:flutter/material.dart';
import 'package:is_counter/database/model/counter/counter.dart';

class CounterSettingViewModel extends ChangeNotifier {
  final CounterSettingViewModelArgs _args;

  Counter get counter => _args.counter;
  String get title => _args.counter.title;

  CounterSettingViewModel(this._args);
}

class CounterSettingViewModelArgs {
  final Counter counter;

  CounterSettingViewModelArgs(this.counter);
}
