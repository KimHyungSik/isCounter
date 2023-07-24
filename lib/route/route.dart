import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:is_counter/presentation/addcounter/add_counter_screen.dart';
import 'package:is_counter/presentation/main/main_screen.dart';

const String mainScreen = 'main';
const String addScreen = 'add';

Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case mainScreen:
      return MaterialPageRoute(builder: (context) => const MainScreen());
    case addScreen:
      return MaterialPageRoute(builder: (context) => const AddCounterScreen());
    default:
      throw ('This route name does not exit');
  }
}
