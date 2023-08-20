import 'package:flutter/material.dart';
import 'package:is_counter/presentation/appbar/app_bar.dart';
import 'package:is_counter/presentation/common/color_picker.dart';
import 'package:is_counter/presentation/pages/counter/counter_viewmodel.dart';
import 'package:provider/provider.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final counterColor =
        counterColors[context.read<CounterViewModel>().counter.color];
    return GestureDetector(
      onTap: () {
        context.read<CounterViewModel>().incrementValue();
      },
      child: Scaffold(
        appBar: AppBarBuilder()
            .removeElevation()
            .setColor(counterColor)
            .setTitle("title")
            .build(),
        body: Container(
          color: counterColor,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Selector<CounterViewModel, String>(
                selector: (context, viewModel) => viewModel.value,
                builder: (context, value, _) {
                  return Text(
                    value,
                    style: const TextStyle(
                      fontSize: 56,
                      color: Colors.white,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
