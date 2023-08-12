import 'package:flutter/material.dart';
import 'package:is_counter/presentation/appbar/app_bar.dart';
import 'package:provider/provider.dart';
import 'package:is_counter/route/route.dart' as route;

import 'main_viewmodel.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MainViewModel viewModel = Provider.of<MainViewModel>(context);
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
      body: ListView.builder(
        itemCount: viewModel.counterList.list.length,
        itemBuilder: ((context, index) {
          final counter = viewModel.counterList.list[index];
          return Text(counter.title);
        }),
      ),
    );
  }
}
