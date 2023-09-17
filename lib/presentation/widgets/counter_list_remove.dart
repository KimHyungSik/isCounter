import 'package:flutter/material.dart';
import 'package:is_counter/database/model/counter/counter.dart';
import 'package:is_counter/presentation/widgets/color_picker.dart';
import 'package:is_counter/presentation/pages/main/main_viewmodel.dart';
import 'package:provider/provider.dart';

class CounterListRemoveItem extends StatelessWidget {
  final Counter counter;
  final Function(Counter) removeFun;

  const CounterListRemoveItem({
    super.key,
    required this.counter,
    required this.removeFun,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<MainViewModel>();
    return ListTile(
      title: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        color: counterColors[counter.color],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IntrinsicWidth(
                child: TextField(
                  controller: TextEditingController(
                    text: counter.title,
                  ),
                  style: const TextStyle(fontSize: 18),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  maxLines: 1,
                  onChanged: (value) {
                    counter.title = value;
                    viewModel.changeTitle(counter);
                  },
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.delete,
                    ),
                    color: Colors.transparent,
                    onPressed: () => {},
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
                    onPressed: () => removeFun(counter),
                    icon: const Icon(
                      Icons.delete,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
