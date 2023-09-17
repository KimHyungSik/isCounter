import 'package:flutter/material.dart';
import 'package:is_counter/database/model/counter/counter_method.dart';
import 'package:is_counter/presentation/appbar/app_bar.dart';
import 'package:is_counter/presentation/pages/counter/button_counter.dart';
import 'package:is_counter/presentation/pages/counter/counter_viewmodel.dart';
import 'package:is_counter/presentation/pages/counter/screen_counter.dart';
import 'package:is_counter/presentation/widgets/color_picker.dart';
import 'package:provider/provider.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final counterColor =
        counterColors[context.read<CounterViewModel>().counter.color];

    return Scaffold(
      appBar: AppBarBuilder()
          .removeElevation()
          .setColor(counterColor)
          .setTitle(context.read<CounterViewModel>().counter.title)
          .build(),
      body: SafeArea(
        child: _counterFactory(context, counterColor),
      ),
    );
  }

  Widget _counterFactory(BuildContext context, Color counterColor) {
    return switch (context.read<CounterViewModel>().counter.counterMethod) {
      Method.BUTTON => buttonCounter(context, counterColor),
      Method.SCREEN => screenTouchCounter(context, counterColor)
    };
  }
}
