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
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: GestureDetector(
          onTap: () {
            context.read<CounterViewModel>().incrementValue();
          },
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Selector<CounterViewModel, String>(
                selector: (context, viewModel) => viewModel.value,
                builder: (context, value, _) {
                  return Text(value);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
