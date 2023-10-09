import 'package:flutter/material.dart';
import 'package:is_counter/route/base_args.dart';
import 'package:is_counter/route/route.dart';
import 'package:provider/provider.dart';

import '../../presentation/pages/main/main_screen.dart';
import '../../presentation/pages/main/main_viewmodel.dart';
import '../base_navigator.dart';

class MainScreenNav extends BaseNavigator {
  MainScreenNav.nav(super.settins) : super.nav();
  MainScreenNav.pushNamed(
      BuildContext context, BaseArgs? args, Function? callback)
      : super.pushNamed(context, args, callback);

  @override
  String get route => mainScreen;

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
  void navigator(BuildContext context, BaseArgs? args, Function? callback) {
    Navigator.pushNamed(
      context,
      route,
    ).then(
      (_) => {if (callback != null) callback()},
    );
  }
}
