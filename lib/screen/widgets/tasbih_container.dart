import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salati/controllers/tasbih_controller.dart';

class Tasbihcontainer extends StatefulWidget {
  const Tasbihcontainer(
      {super.key, required this.controller, required this.count, required this.reset, required this.currentTasbihIndex});

  final TasbihController controller;
  final int count;
  final Function() reset;
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
                style: GoogleFonts.amiri(
                  fontSize: 24,
                  color: Theme.of(context).colorScheme.background
                ),
              ),
              Text(
                widget.controller.getCurrentTasbih(widget.currentTasbihIndex).tasbihArabEng,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 15,
                  color: Theme.of(context).colorScheme.background
                ),
              ),
              Text(
                widget.controller.getCurrentTasbih(widget.currentTasbihIndex).tasbihEnglish,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                  color: Theme.of(context).colorScheme.background
                ),
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
              onTap: widget.reset,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      Theme.of(context).colorScheme.background.withOpacity(0.5),
                ),
                width: 40,
                height: 40,
                child: const Center(
                  child: Image(image: AssetImage('assets/images/new_tasbih.png')),
                ),
              ))
        ],
      ),
    );
  }
}
