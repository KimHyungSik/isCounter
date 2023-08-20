import 'package:flutter/material.dart';
import 'package:is_counter/database/model/counter/counter.dart';
import 'package:is_counter/presentation/appbar/app_bar.dart';
import 'package:is_counter/presentation/pages/counter/counter_viewmodel.dart';
import 'package:is_counter/presentation/pages/main/state/main_state.dart';
import 'package:provider/provider.dart';
import 'package:is_counter/route/route.dart' as route;

import '../../widgets/counter_list_item.dart';
import '../addcounter/add_counter_viewmodel.dart';
import 'main_viewmodel.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBuilder()
          .setEndIcon(
            const Icon(Icons.add),
            () {
              Navigator.pushNamed(
                context,
                route.addScreen,
                arguments: AddCounterViewModelArgs(
                  (context.read<MainViewModel>().counterList.list.length + 1)
                      .toString(),
                ),
              ).then((_) => context.read<MainViewModel>().getCounterList());
            },
          )
          .setEndNav(
            const Icon(Icons.more_horiz),
            () {},
          )
          .build(),
      body: Selector<MainViewModel, MainState>(
        selector: (context, viewModel) => viewModel.state,
        builder: (context, _, child) {
          final viewModel = context.read<MainViewModel>();
          return ListView.builder(
            itemCount: viewModel.counterList.list.length,
            itemBuilder: ((context, index) {
              final counter = viewModel.counterList.list[index];
              return CounterListItem(
                counter: counter,
                incrementValue: () => viewModel.incrementValue(counter),
                decrementValue: () => viewModel.decrementValue(counter),
                navigatorCounterScreen: (Counter counter) {
                  Navigator.pushNamed(
                    context,
                    route.counterScreen,
                    arguments: CounterViewModelArgs(counter),
                  ).then((_) => context.read<MainViewModel>().getCounterList());
                },
              );
            }),
          );
        },
      ),
    );
  }
}
