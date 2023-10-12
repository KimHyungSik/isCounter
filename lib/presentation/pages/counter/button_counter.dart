import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:is_counter/presentation/appbar/app_bar.dart';
import 'package:is_counter/presentation/pages/counter/counter_button.dart';
import 'package:is_counter/presentation/pages/counter/counter_viewmodel.dart';
import 'package:provider/provider.dart';

Widget buttonCounter(BuildContext context, Color counterColor) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const Spacer(
        flex: 2,
      ),
      Flexible(
        flex: 3,
        fit: FlexFit.tight,
        child: Selector<CounterViewModel, String>(
          selector: (context, viewModel) => viewModel.value,
          builder: (context, value, _) {
            return Text(
              value,
              style: const TextStyle(
                fontSize: 56,
                color: Colors.black,
              ),
            );
          },
        ),
      ),
      Flexible(
        flex: 3,
        fit: FlexFit.tight,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: counterButton(
                  context,
                  const Icon(Icons.remove),
                  counterColor,
                  () {
                    if (context.read<CounterViewModel>().counter.vibration) {
                      HapticFeedback.lightImpact();
                    }
                    context.read<CounterViewModel>().decrementValue();
                  },
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: counterButton(
                  context,
                  const Icon(Icons.add),
                  counterColor,
                  () {
                    if (context.read<CounterViewModel>().counter.vibration) {
                      HapticFeedback.lightImpact();
                    }
                    context.read<CounterViewModel>().incrementValue();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      const Spacer(
        flex: 1,
      )
    ],
  );
}
