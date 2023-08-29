import 'package:flutter/material.dart';
import 'package:is_counter/database/model/counter/counter_method.dart';
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
    switch (context.read<CounterViewModel>().counter.counterMethod) {
      case Method.BUTTON:
        return buttonCounter(context, counterColor);
      case Method.SCREEN:
        return screenTouchCounter(context, counterColor);
    }
  }

  Widget buttonCounter(BuildContext context, Color counterColor) {
    return Scaffold(
      appBar: AppBarBuilder()
          .removeElevation()
          .setColor(counterColor)
          .setTitle(context.read<CounterViewModel>().counter.title)
          .build(),
      body: Column(
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
          const Spacer(),
          Row(
            children: [
              _myIconButton(
                context,
                const Icon(Icons.remove),
                counterColor,
                () {
                  context.read<CounterViewModel>().decrementValue();
                },
              ),
              const SizedBox(
                width: 16,
              ),
              _myIconButton(
                context,
                const Icon(Icons.add),
                counterColor,
                () {
                  context.read<CounterViewModel>().incrementValue();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  GestureDetector screenTouchCounter(BuildContext context, Color counterColor) {
    return GestureDetector(
      onTap: () {
        context.read<CounterViewModel>().incrementValue();
      },
      child: Scaffold(
        appBar: AppBarBuilder()
            .removeElevation()
            .setColor(counterColor)
            .setTitle(context.read<CounterViewModel>().counter.title)
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

  Widget _myIconButton(
    BuildContext context,
    Icon icon,
    Color background,
    VoidCallback onPressed,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(16),
      ),
      child: IconButton(
        icon: icon,
        onPressed: onPressed,
        color: Colors.white,
      ),
    );
  }
}
