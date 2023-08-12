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
      {
        final arg = settings.arguments;
        if (arg is AddCounterArgs) {
          return MaterialPageRoute(
              builder: (context) => AddCounterScreen(addCounterArgs: arg));
        } else {
          return MaterialPageRoute(
              builder: (context) =>
                  AddCounterScreen(addCounterArgs: AddCounterArgs(null)));
        }
      }
    default:
      throw ('This route name does not exit');
  }
}
