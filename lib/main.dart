import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:is_counter/presentation/pages/addcounter/add_counter_viewmodel.dart';
import 'package:is_counter/route/route.dart' as route;
import 'package:is_counter/presentation/pages/main/main_viewmodel.dart';
import 'package:is_counter/theme/colors.dart';
import 'package:provider/provider.dart';

import 'generated/l10n.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
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
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''),
          Locale('ko', ''),
        ],
        onGenerateRoute: route.controller,
        initialRoute: route.mainScreen,
      ),
    );
  }
}
