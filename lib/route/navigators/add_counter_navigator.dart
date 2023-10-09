import 'package:flutter/src/material/page.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/navigator.dart';
import 'package:is_counter/presentation/pages/addcounter/add_counter_screen.dart';
import 'package:is_counter/presentation/pages/addcounter/add_counter_viewmodel.dart';
import 'package:is_counter/route/base_args.dart';
import 'package:is_counter/route/base_navigator.dart';
import 'package:is_counter/route/route.dart';
import 'package:provider/provider.dart';

class AddCounterNav extends BaseNavigator<AddCounterViewModelArgs> {
  @override
  String get route => addScreen;

  AddCounterNav.nav(RouteSettings settins) {
    this.settins = settins;
  }

  AddCounterNav.navigate(
      BuildContext context, AddCounterViewModelArgs args, Function? callback) {
    navigate(context, args, callback);
  }

  @override
  MaterialPageRoute pageRoute() {
    return MaterialPageRoute(
      builder: (context) => ChangeNotifierProvider(
        create: (_) => AddCounterViewModel(args?.titleCounter),
        child: AddCounterScreen(),
      ),
    );
  }

  @override
  void navigate(
      BuildContext context, AddCounterViewModelArgs args, Function? callback) {
    Navigator.pushNamed(context, route, arguments: args).then(
      (_) => {if (callback != null) callback()},
    );
  }
}
