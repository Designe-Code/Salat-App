import 'package:flutter/material.dart';
import 'package:salati/controllers/tasbih_controller.dart';
import 'package:salati/models/tasbih_data.dart';

class Tasbihcontainer extends StatefulWidget {
  const Tasbihcontainer(
      {super.key, required this.controller, required this.count, required this.increment, required this.currentTasbihIndex});

  final TasbihController controller;
  final int count;
  final Function() increment;
  final int currentTasbihIndex;

  @override
  State<Tasbihcontainer> createState() => _TasbihcontainerState();
}

class _TasbihcontainerState extends State<Tasbihcontainer> {
  @override
  Widget build(BuildContext context) {
    

    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.controller.getCurrentTasbih(widget.currentTasbihIndex).tasbihArab,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                widget.controller.getCurrentTasbih(widget.currentTasbihIndex).tasbihArabEng,
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                widget.controller.getCurrentTasbih(widget.currentTasbihIndex).tasbihEnglish,
                style:
                    const TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
              ),
              // Text(
              //   '$count / 33',
              //   style: const TextStyle(fontSize: 16),
              // ),
              // ElevatedButton(
              //   onPressed: incrementCount,
              //   child: const Text('Increment'),
              // ),
            ],
          ),
          InkWell(
              onTap: widget.increment,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      Theme.of(context).colorScheme.background.withOpacity(0.5),
                ),
                width: 40,
                height: 40,
                child: Center(
                  child: Icon(Icons.restart_alt_outlined),
                ),
              ))
        ],
      ),
    );
  }
}
