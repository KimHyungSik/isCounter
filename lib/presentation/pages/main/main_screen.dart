import 'package:flutter/material.dart';
import 'package:is_counter/database/model/counter/counter.dart';
import 'package:is_counter/presentation/appbar/app_bar.dart';
import 'package:is_counter/presentation/pages/counter/counter_viewmodel.dart';
import 'package:is_counter/presentation/pages/main/state/main_mode.dart';
import 'package:is_counter/presentation/pages/main/state/main_state.dart';
import 'package:is_counter/presentation/widgets/counter/counter_list_item.dart';
import 'package:is_counter/presentation/widgets/counter/counter_list_remove.dart';
import 'package:is_counter/route/navigators/add_counter_navigator.dart';
import 'package:is_counter/route/navigators/counter_navigator.dart';
import 'package:provider/provider.dart';
import 'package:is_counter/route/route.dart' as route;
import 'package:tuple/tuple.dart';

import '../addcounter/add_counter_viewmodel.dart';
import 'main_viewmodel.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBuilder().setEndIcon(
        const Icon(Icons.add),
        () {
          final args = AddCounterViewModelArgs(
            (context.read<MainViewModel>().counterList.list.length + 1)
                .toString(),
          );
          AddCounterNav.pushNamed(
            context,
            args,
            () {
              context.read<MainViewModel>().getCounterList();
            },
          );
        },
      ).setEndNav(
        const Icon(Icons.more_horiz),
        () {
          context.read<MainViewModel>().changeMode();
        },
      ).build(),
      body: Selector<MainViewModel, Tuple2<MainState, MainMode>>(
        selector: (context, viewModel) =>
            Tuple2(viewModel.state, viewModel.mode),
        builder: (context, data, child) {
          final viewModel = context.read<MainViewModel>();
          return ListView.builder(
            itemCount: viewModel.counterList.list.length,
            itemBuilder: ((context, index) {
              final counter = viewModel.counterList.list[index];
              return counterListView(counter, viewModel, context, data.item2);
            }),
          );
        },
      ),
    );
  }

  Widget counterListView(Counter counter, MainViewModel viewModel,
      BuildContext context, MainMode mode) {
    if (mode == MainMode.COUNTER) {
      return CounterListItem(
        counter: counter,
        incrementValue: () => viewModel.incrementValue(counter),
        decrementValue: () => viewModel.decrementValue(counter),
        navigatorCounterScreen: (Counter counter) {
          CounterNav.pushNamed(
            context,
            CounterViewModelArgs(counter),
            () {
              (_) => context.read<MainViewModel>().getCounterList();
            },
          );
        },
      );
    } else {
      return CounterListRemoveItem(
        counter: counter,
        removeFun: (counter) => viewModel.removeCounter(counter),
      );
    }
  }
}
