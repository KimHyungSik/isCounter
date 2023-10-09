import 'package:flutter/material.dart';

import 'base_args.dart';

abstract class BaseNavigator<T extends BaseArgs> {
  BaseNavigator.nav(RouteSettings this.settins);
  BaseNavigator.pushNamed(BuildContext context, T? args, Function? callback) {
    navigator(context, args, callback);
  }

  T? get args => settins?.arguments as T;
  String get route;
  RouteSettings? settins;

  void navigator(BuildContext context, T? args, Function? callback);
  MaterialPageRoute pageRoute();
}
