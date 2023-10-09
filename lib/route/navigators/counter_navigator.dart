import 'package:flutter/material.dart';
import 'package:is_counter/presentation/pages/counter/counter_screen.dart';
import 'package:is_counter/presentation/pages/counter/counter_viewmodel.dart';
import 'package:is_counter/route/base_navigator.dart';
import 'package:is_counter/route/route.dart';
import 'package:provider/provider.dart';

class CounterNav extends BaseNavigator<CounterViewModelArgs> {
  CounterNav.nav(super.settins) : super.nav();
  CounterNav.pushNamed(
      BuildContext context, CounterViewModelArgs? args, Function? callback)
      : super.pushNamed(context, args, callback);

  @override
  String get route => counterScreen;

  @override
  MaterialPageRoute pageRoute() {
    final counter = args?.counter;
    if (counter == null) {
      throw Exception("counter does not exist.");
    }
    return MaterialPageRoute(
      builder: (context) => ChangeNotifierProvider(
        create: (context) => CounterViewModel(counter),
        child: const CounterScreen(),
      ),
    );
  }

  @override
  void navigator(
      BuildContext context, CounterViewModelArgs? args, Function? callback) {
    Navigator.pushNamed(context, route, arguments: args).then(
      (_) => {if (callback != null) callback()},
    );
  }
}
