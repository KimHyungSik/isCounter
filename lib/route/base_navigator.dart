import 'package:flutter/material.dart';

import 'base_args.dart';

abstract class BaseNavigator<T extends BaseArgs> {
  T? get args => settins?.arguments as T;
  String get route;
  RouteSettings? settins;

  void navigate(BuildContext context, T args, Function? callback);
  MaterialPageRoute pageRoute();
}
