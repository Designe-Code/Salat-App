import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:salati/helper/constant.dart';
import 'package:salati/helper/theme.dart';
import 'package:salati/screen/spalsh_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      theme: lightTheme,
      home: const SplashScreen(),
    );
  }
}