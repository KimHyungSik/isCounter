import 'package:flutter/material.dart';
import 'package:is_counter/database/model/counter/counter.dart';
import 'package:is_counter/database/model/tags/tags.dart';
import 'package:is_counter/presentation/pages/main/main_viewmodel.dart';
import 'package:is_counter/presentation/widgets/color_picker.dart';
import 'package:provider/provider.dart';

class CounterListItem extends StatelessWidget {
  final Counter counter;
  final Function() incrementValue;
  final Function() decrementValue;
  final Function(Counter) navigatorCounterScreen;

  const CounterListItem({
    super.key,
    required this.counter,
    required this.incrementValue,
    required this.decrementValue,
    required this.navigatorCounterScreen,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: GestureDetector(
        onTap: () => navigatorCounterScreen(counter),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          color: counterColors[counter.color],
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (counter.tag != null)
                        Icon(
                          CounterTags.nameToIcon(counter.tag!),
                          size: 20.0,
                        ),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(
                        counter.title,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
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
      ),
    );
  }
}
