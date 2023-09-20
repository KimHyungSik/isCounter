import 'package:flutter/material.dart';
import 'package:is_counter/presentation/appbar/app_bar.dart';
import 'package:is_counter/presentation/pages/counter_setting/counter_setting_viewmodel.dart';
import 'package:provider/provider.dart';

class CounterSettingScreen extends StatelessWidget {
  const CounterSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBuilder()
          .setTitle(context.read<CounterSettingViewModel>().title)
          .build(),
      body: Container(),
    );
  }
}
