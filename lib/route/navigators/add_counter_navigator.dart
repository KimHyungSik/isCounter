import 'package:flutter/src/material/page.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/navigator.dart';
import 'package:is_counter/presentation/pages/addcounter/add_counter_screen.dart';
import 'package:is_counter/presentation/pages/addcounter/add_counter_viewmodel.dart';
import 'package:is_counter/route/base_navigator.dart';
import 'package:is_counter/route/route.dart';
import 'package:provider/provider.dart';

class AddCounterNav extends BaseNavigator<AddCounterViewModelArgs> {
  AddCounterNav.nav(super.settins) : super.nav();
  AddCounterNav.pushNamed(BuildContext context, AddCounterViewModelArgs? args,
      Function(dynamic)? callback)
      : super.pushNamed(context, args, callback);

  @override
  String get route => addScreen;

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
  void navigator(BuildContext context, AddCounterViewModelArgs? args,
      Function(dynamic)? callback) {
    Navigator.pushNamed(context, route, arguments: args).then(
      (value) => {if (callback != null) callback(value)},
    );
  }
}
