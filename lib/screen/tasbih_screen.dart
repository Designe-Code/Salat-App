import 'package:flutter/material.dart';
import 'package:salati/controllers/tasbih_controller.dart';
import 'package:salati/models/tasbih_data.dart';
import 'package:salati/screen/widgets/tasbih/tasbih_button.dart';
import 'package:salati/screen/widgets/tasbih/tasbih_container.dart';
import 'package:salati/screen/widgets/tasbih/tasbih_text.dart';

class TasbihScreen extends StatefulWidget {
  final TasbihController controller;
  const TasbihScreen({super.key, required this.controller});

  @override
  State<TasbihScreen> createState() => _TasbihState();
}

class _TasbihState extends State<TasbihScreen> {
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
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Tasbih", style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
              Tasbihnumbers(
                count: count,
                currentTasbih: _currentTasbihIndex,
                decrement: decrement,
                reset: reset
              ),
              Column(
                children: [
                  Tasbihcontainer(
                    controller: tasbihController,
                    count: count,
                    reset: reset,
                    currentTasbihIndex: _currentTasbihIndex,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  TasbihButton(
                    increment: increment,
                  ),
                ],
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
      if (lastCounter < 101) {
        count = count + 1;
      } else {
        lastCounter = 101;
      }
      if (lastCounter == 34 || lastCounter == 67) {
        count = 1;
      }
      if (lastCounter < 34) {
        _currentTasbihIndex = 0;
      } else if (lastCounter < 67) {
        _currentTasbihIndex = 1;
      } else if (lastCounter < 101) {
        _currentTasbihIndex = 2;
      }
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
      if (lastCounter > 0) {
        count--;
        lastCounter--;
      }
      if (lastCounter == 33 || lastCounter == 66) {
        count = 33;
      }
      if (lastCounter < 34) {
        _currentTasbihIndex = 0;
      } else if (lastCounter < 67) {
        _currentTasbihIndex = 1;
      } else if (lastCounter < 101) {
        _currentTasbihIndex = 2;
      }
    });
  }
}
