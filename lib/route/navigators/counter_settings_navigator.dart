import 'package:flutter/material.dart';
import 'package:is_counter/presentation/pages/counter_setting/counter_setting_screen.dart';
import 'package:is_counter/presentation/pages/counter_setting/counter_setting_viewmodel.dart';
import 'package:is_counter/route/base_navigator.dart';
import 'package:is_counter/route/route.dart';
import 'package:provider/provider.dart';

class CounterSettingNav extends BaseNavigator<CounterSettingViewModelArgs> {
  CounterSettingNav.nav(super.settins) : super.nav();
  CounterSettingNav.pushNamed(BuildContext context,
      CounterSettingViewModelArgs args, Function(dynamic)? callback)
      : super.pushNamed(context, args, callback);

  @override
  String get route => counterSetting;

  @override
  MaterialPageRoute pageRoute() {
    return MaterialPageRoute(
      builder: (context) => ChangeNotifierProvider(
        create: (context) => CounterSettingViewModel(args!),
        child: const CounterSettingScreen(),
      ),
    );
  }

  @override
  void navigator(BuildContext context, CounterSettingViewModelArgs? args,
      Function(dynamic)? callback) {
    Navigator.pushNamed(context, counterSetting, arguments: args)
        .then((value) => callback?.call(value));
  }
}
