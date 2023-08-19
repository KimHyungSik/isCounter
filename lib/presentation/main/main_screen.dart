import 'package:flutter/material.dart';
import 'package:is_counter/database/model/counter/counter.dart';
import 'package:is_counter/presentation/appbar/app_bar.dart';
import 'package:provider/provider.dart';
import 'package:is_counter/route/route.dart' as route;

import '../addcounter/add_counter_screen.dart';
import '../common/color_picker.dart';
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
              Navigator.pushNamed(
                context,
                route.addScreen,
                arguments:
                    AddCounterArgs(viewModel.counterList.list.length + 1),
              ).then((_) => viewModel.getCounterList());
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
          return NumberListItem(
            counter: counter,
            incrementValue: () => viewModel.incrementValue(counter),
            decrementValue: () => viewModel.decrementValue(counter),
          );
        }),
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
                  Text(
                    counter.value.toString(),
                    style: const TextStyle(fontSize: 18),
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
