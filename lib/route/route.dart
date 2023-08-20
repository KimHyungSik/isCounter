import 'package:flutter/material.dart';
import 'package:is_counter/presentation/pages/addcounter/add_counter_screen.dart';
import 'package:is_counter/presentation/pages/addcounter/add_counter_viewmodel.dart';
import 'package:is_counter/presentation/pages/main/main_screen.dart';
import 'package:provider/provider.dart';

const String mainScreen = 'main';
const String addScreen = 'add';

Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case mainScreen:
      return MaterialPageRoute(builder: (context) => const MainScreen());
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
    default:
      throw ('This route name does not exit');
  }
}
