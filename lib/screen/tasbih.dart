import 'package:flutter/material.dart';
import 'package:salati/controllers/tasbih_controller.dart';
import 'package:salati/models/tasbih_data.dart';
import 'package:salati/screen/widgets/tasbih_button.dart';
import 'package:salati/screen/widgets/tasbih_container.dart';
import 'package:salati/screen/widgets/tasbih_text.dart';

class Tasbih extends StatefulWidget {
  final TasbihController controller;
  const Tasbih({super.key, required this.controller});

  @override
  State<Tasbih> createState() => _TasbihState();
}

class _TasbihState extends State<Tasbih> {
  late TasbihData currentTasbih;
  int count = 0;
  int lastCounter = 0;
  int _currentTasbihIndex = 0;

  @override
  void initState() {
    super.initState();
    currentTasbih = widget.controller.getCurrentTasbih(_currentTasbihIndex);
  }

  @override
  Widget build(BuildContext context) {
    TasbihController tasbihController = TasbihController();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Text("data"),
              Tasbihnumbers(count: count, decrement: decrement, reset: reset),
              Tasbihcontainer(
                controller: tasbihController,
                count: count,
                increment: increment,
                currentTasbihIndex: _currentTasbihIndex,
              ),
              TasbihButton(
                increment: increment,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void increment() {
    setState(() {
      lastCounter = lastCounter + 1;
      if (lastCounter == 101) {
        lastCounter = 0;
      }
      if (lastCounter == 33 || lastCounter == 66 || lastCounter == 100) {
        count = 0;
      }
      if (lastCounter < 34) {
        _currentTasbihIndex = 0;
      } else if (lastCounter < 66) {
        _currentTasbihIndex = 1;
      } else if (lastCounter < 99) {
        _currentTasbihIndex = 2;
      }

      count = count + 1;
      print(lastCounter);
      print(_currentTasbihIndex);
    });
  }

  void reset() {
    setState(() {
      lastCounter = 0;
      count = 0;
      _currentTasbihIndex = 0;
    });
  }

  void decrement() {
    setState(() {
      if (count > 0) {
        count--;
        if (lastCounter > 0) {
          lastCounter--;
        }
      }
    });
  }
}
