import 'package:flutter/material.dart';
import 'package:is_counter/route/base_args.dart';
import 'package:is_counter/route/route.dart';
import 'package:provider/provider.dart';

import '../../presentation/pages/main/main_screen.dart';
import '../../presentation/pages/main/main_viewmodel.dart';
import '../base_navigator.dart';

class MainScreenNav extends BaseNavigator {
  @override
  String get route => mainScreen;

  MainScreenNav.nav(RouteSettings settins) {
    this.settins = settins;
  }

  MainScreenNav.navigate(
      BuildContext context, BaseArgs args, Function? callback) {
    navigate(context, args, callback);
  }

  @override
  MaterialPageRoute pageRoute() {
    return MaterialPageRoute(
      builder: (context) => ChangeNotifierProvider(
        create: (_) => MainViewModel(),
        child: const MainScreen(),
      ),
    );
  }

  @override
  void navigate(BuildContext context, BaseArgs args, Function? callback) {
    Navigator.pushNamed(
      context,
      route,
    ).then(
      (_) => {if (callback != null) callback()},
    );
  }
}
