import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:is_counter/presentation/appbar/app_bar.dart';
import 'package:provider/provider.dart';
import 'package:is_counter/route/route.dart' as route;

import '../../database/model/counter/counter.dart';
import '../../database/model/counter/counter_method.dart';
import 'main_viewmodel.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MainViewModel viewModel = Provider.of<MainViewModel>(context);
    final counter = Counter(
        id: "1",
        title: "title",
        color: "color",
        startValue: 0,
        incrementValue: 1,
        counterMethod: Method.BUTTON);
    viewModel.setCounterList([counter]);

    return Scaffold(
      appBar: AppBarBuilder()
          .setEndIcon(
            const Icon(Icons.add),
            () {
              Navigator.pushNamed(context, route.addScreen);
            },
          )
          .setEndNav(
            const Icon(Icons.more_horiz),
            () {},
          )
          .build(),
      body: Center(
        child: Column(
          children: [
            Text(viewModel.list.isEmpty
                ? Intl.message('title')
                : viewModel.list[0].title),
            Text(
              Intl.message('title'),
            ),
          ],
        ),
      ),
    );
  }
}
