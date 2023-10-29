import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:is_counter/route/route.dart' as route;
import 'package:is_counter/theme/colors.dart';

import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: lightPrimaryColor,
        scaffoldBackgroundColor: lightBackgroundColor,
        dividerColor: lightDividerColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: lightPrimaryColor,
          titleTextStyle: TextStyle(
            color: Colors.white,
          ),
        ),
        fontFamily: "GmarketSans",
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
    );
  }
}
