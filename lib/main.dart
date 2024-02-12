import 'package:flutter/material.dart';
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
    return MaterialApp(
      title: appName,
      theme: lightTheme,
      home: const SplashScreen(),
    );
  }
}