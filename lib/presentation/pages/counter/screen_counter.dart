import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:is_counter/presentation/pages/counter/counter_viewmodel.dart';
import 'package:provider/provider.dart';

GestureDetector screenTouchCounter(BuildContext context, Color counterColor) {
  return GestureDetector(
    onTap: () {
      HapticFeedback.lightImpact();
      context.read<CounterViewModel>().incrementValue();
    },
    child: Container(
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
  );
}
