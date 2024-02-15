import 'package:flutter/material.dart';
import 'package:salati/controllers/tasbih_controller.dart';
import 'package:salati/models/tasbih_data.dart';

class Tasbihcontainer extends StatefulWidget {
  const Tasbihcontainer({
    Key? key,
  }) : super(key: key);

  @override
  State<Tasbihcontainer> createState() => _TasbihcontainerState();
}

class _TasbihcontainerState extends State<Tasbihcontainer> {
  TasbihController tasbihController = TasbihController();
  int count = 0;

  void incrementCount() {
    setState(() {
      count = (count + 1) % 34;

      // Check if the count is zero, meaning we completed 33
      if (count == 0) {
        // Move to the next Tasbih
        tasbihController.moveToNextTasbih();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    TasbihData currentTasbih = tasbihController.getCurrentTasbih();

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
                currentTasbih.tasbihArab,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                currentTasbih.tasbihArabEng,
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                currentTasbih.tasbihEnglish,
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
          InkWell(onTap: () {}, child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.background.withOpacity(0.5),
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
