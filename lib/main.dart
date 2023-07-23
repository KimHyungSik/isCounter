import 'package:flutter/material.dart';
import 'package:is_counter/main/main_viewmodel.dart';
import 'package:provider/provider.dart';

import 'database/model/counter.dart';
import 'database/model/counter_method.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => MainViewModel())],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Scaffold(
          body: MyWidget(),
        ),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    MainViewModel viewModel = Provider.of<MainViewModel>(context);
    final counter = Counter(
        id: "1",
        title: "title",
        color: "color",
        startValue: 0,
        incrementValue: 1,
        counterMethod: Method.BUTTON);
    viewModel.setCounterList([counter]);

    return Center(
      child: Text(viewModel.list.isEmpty ? "isEmpty" : viewModel.list[0].title),
    );
  }
}
