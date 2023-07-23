import 'package:flutter/material.dart';
import 'package:is_counter/main/main_viewmodel.dart';
import 'package:provider/provider.dart';

import 'main/main_screen.dart';

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
