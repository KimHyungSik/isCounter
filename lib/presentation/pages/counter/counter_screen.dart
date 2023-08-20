import 'package:flutter/material.dart';
import 'package:is_counter/presentation/appbar/app_bar.dart';
import 'package:is_counter/presentation/pages/counter/counter_viewmodel.dart';
import 'package:provider/provider.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBuilder().setTitle("title").build(),
      body: GestureDetector(
        onTap: () {
          context.read<CounterViewModel>().incrementValue();
        },
        child: Center(
          child: Selector<CounterViewModel, String>(
            selector: (context, viewModel) => viewModel.value,
            builder: (context, value, _) {
              return Text(value);
            },
          ),
        ),
      ),
    );
  }
}
