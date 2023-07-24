import 'package:flutter/material.dart';
import 'package:is_counter/presentation/appbar/app_bar.dart';

class AddCounterScreen extends StatelessWidget {
  const AddCounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBuilder().build(),
      body: const Column(children: []),
    );
  }
}
