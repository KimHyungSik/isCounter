import 'package:flutter/material.dart';
import 'package:is_counter/presentation/pages/addcounter/add_counter_screen.dart';
import 'package:is_counter/presentation/pages/addcounter/add_counter_viewmodel.dart';
import 'package:is_counter/presentation/pages/counter/counter_screen.dart';
import 'package:is_counter/presentation/pages/counter/counter_viewmodel.dart';
import 'package:is_counter/presentation/pages/main/main_screen.dart';
import 'package:is_counter/presentation/pages/main/main_viewmodel.dart';
import 'package:provider/provider.dart';

const String mainScreen = 'main';
const String addScreen = 'add';
const String counterScreen = "counter";

Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case mainScreen:
      return MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (_) => MainViewModel(),
          child: const MainScreen(),
        ),
      );
    case addScreen:
      {
        final arg = settings.arguments as AddCounterViewModelArgs;

        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (_) => AddCounterViewModel(arg.titleCounter),
            child: AddCounterScreen(),
          ),
        );
      }
    case counterScreen:
      final arg = settings.arguments as CounterViewModelArgs;

      return MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (context) => CounterViewModel(arg.counter),
          child: const CounterScreen(),
        ),
      );
    default:
      throw ('This route name does not exit');
  }
}
