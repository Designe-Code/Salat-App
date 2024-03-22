import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:salati/helper/constant.dart';
import 'package:salati/providers/prayer_provider.dart';
import 'package:salati/providers/quran_provider.dart';
import 'package:salati/providers/splash_provider.dart';
import 'package:salati/providers/theme_provider.dart';
import 'package:salati/screen/spalsh_screen.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ChangeNotifierProvider(create: (context) => SplashProvider()),
      ChangeNotifierProvider(create: (context) => PrayerProvider()),
      ChangeNotifierProvider(create: (context) => QuranProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: appName,
          theme: themeProvider.themeData,
          home: const SplashScreen(),
        );
      },
    );
  }
}
