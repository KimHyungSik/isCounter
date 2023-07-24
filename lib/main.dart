import 'package:flutter/material.dart';
import 'package:is_counter/presentation/main/main_viewmodel.dart';
import 'package:is_counter/theme/colors.dart';
import 'package:provider/provider.dart';

import 'presentation/main/main_screen.dart';

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
        theme: ThemeData.light().copyWith(
          primaryColor: lightPrimaryColor,
          scaffoldBackgroundColor: lightBackgroundColor,
          dividerColor: lightDividerColor,
          appBarTheme: const AppBarTheme(
            backgroundColor: lightPrimaryColor,
            titleTextStyle: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        darkTheme: ThemeData.dark().copyWith(
          primaryColor: darkPrimaryColor,
          scaffoldBackgroundColor: darkBackgroundColor,
          dividerColor: darkDividerColor,
        ),
        themeMode: ThemeMode.system,
        home: MyWidget(),
      ),
    );
  }
}
