import 'package:flutter/material.dart';

class Tasbihnumbers extends StatefulWidget {
  const Tasbihnumbers({
    super.key,
    required this.count,
    required this.currentTasbih,
    required this.decrement,
    required this.reset
  });

  final int count;
  final int currentTasbih;
  final Function() decrement;
  final Function() reset;

  @override
  State<Tasbihnumbers> createState() => _TasbihnumbersState();
}

class _TasbihnumbersState extends State<Tasbihnumbers> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: widget.count.toString(),
                style: const TextStyle(
                  color: Color(0xFF06D6A0),
                  fontSize: 96,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
              TextSpan(
                text: widget.currentTasbih == 2 ? '/34' : '/33',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 150,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: widget.decrement,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  child: Center(
                    child: Icon(Icons.audiotrack_rounded,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: widget.reset,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  child: Center(
                    child: Icon(Icons.rotate_right_rounded,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  widget.decrement();
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  child: Center(
                    child: Icon(Icons.remove,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
