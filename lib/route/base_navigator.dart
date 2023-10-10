import 'package:flutter/material.dart';

import 'base_args.dart';

abstract class BaseNavigator<T extends BaseArgs> {
  BaseNavigator.nav(RouteSettings this.settings);
  BaseNavigator.pushNamed(
      BuildContext context, T? args, Function(dynamic)? callback) {
    navigator(context, args, callback);
  }

  T? get args => settings?.arguments as T;
  String get route;
  RouteSettings? settings;

  void navigator(BuildContext context, T? args, Function(dynamic)? callback);
  MaterialPageRoute pageRoute();
}
