import 'package:flutter/material.dart';
import 'package:is_counter/database/model/counter/counter.dart';
import 'package:is_counter/presentation/appbar/app_bar.dart';
import 'package:is_counter/presentation/main/state/main_state.dart';
import 'package:provider/provider.dart';
import 'package:is_counter/route/route.dart' as route;

import '../addcounter/add_counter_screen.dart';
import '../common/color_picker.dart';
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
                arguments: AddCounterArgs(
                    context.read<MainViewModel>().counterList.list.length + 1),
              ).then((_) => context.read<MainViewModel>().getCounterList());
            },
          )
          .setEndNav(
            const Icon(Icons.more_horiz),
            () {},
          )
          .build(),
      body: Selector<MainViewModel, MainState>(
        selector: (context, viewModel) {
          print("${viewModel.state}");
          return viewModel.state;
        },
        builder: (context, _, child) {
          final viewModel = context.read<MainViewModel>();
          return ListView.builder(
            itemCount: viewModel.counterList.list.length,
            itemBuilder: ((context, index) {
              final counter = viewModel.counterList.list[index];
              return NumberListItem(
                counter: counter,
                incrementValue: () => viewModel.incrementValue(counter),
                decrementValue: () => viewModel.decrementValue(counter),
              );
            }),
          );
        },
      ),
    );
  }
}

class NumberListItem extends StatelessWidget {
  final Counter counter;
  Function() incrementValue;
  Function() decrementValue;

  NumberListItem({
    super.key,
    required this.counter,
    required this.incrementValue,
    required this.decrementValue,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        color: counterColors[counter.color],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                counter.title,
                style: const TextStyle(fontSize: 18),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () => decrementValue(),
                  ),
                  const Spacer(),
                  Consumer<MainViewModel>(
                    builder: (context, viewModel, _) => Text(
                      viewModel.getCounter(counter.id).value.toString(),
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => incrementValue(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
