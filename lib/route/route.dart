import 'package:flutter/material.dart';
import 'package:is_counter/presentation/pages/addcounter/add_counter_screen.dart';
import 'package:is_counter/presentation/pages/addcounter/add_counter_viewmodel.dart';
import 'package:is_counter/presentation/pages/counter/counter_screen.dart';
import 'package:is_counter/presentation/pages/counter/counter_viewmodel.dart';
import 'package:is_counter/presentation/pages/counter_setting/counter_setting_screen.dart';
import 'package:is_counter/presentation/pages/counter_setting/counter_setting_viewmodel.dart';
import 'package:is_counter/presentation/pages/main/main_screen.dart';
import 'package:is_counter/presentation/pages/main/main_viewmodel.dart';
import 'package:is_counter/route/navigators/add_counter_navigator.dart';
import 'package:is_counter/route/navigators/counter_navigator.dart';
import 'package:is_counter/route/navigators/main_navigator.dart';
import 'package:provider/provider.dart';

const String mainScreen = 'main';
const String addScreen = 'add';
const String counterScreen = "counter";
const String counterSetting = "settingCounter";

Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case mainScreen:
      return MainScreenNav.nav(settings).pageRoute();
    case addScreen:
      return AddCounterNav.nav(settings).pageRoute();
    case counterScreen:
      return CounterNav.nav(settings).pageRoute();
    case counterSetting:
      final arg = settings.arguments as CounterSettingViewModelArgs;

      return MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (context) => CounterSettingViewModel(arg),
          child: const CounterSettingScreen(),
        ),
      );
    default:
      throw ('This route name does not exit');
  }
}
