import 'package:flutter/material.dart';
import 'package:salati/screen/widgets/tasbih_button.dart';
import 'package:salati/screen/widgets/tasbih_container.dart';
import 'package:salati/screen/widgets/tasbih_text.dart';

class Tasbih extends StatelessWidget {
  const Tasbih({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
            Text ("data"),
            Tasbihnumbers(),
            Tasbihcontainer (),
            TasbihButton(),
            ],
          ),
        ),
      ),
    );
  }
}