import 'package:flutter/material.dart';

class Tasbihnumbers extends StatefulWidget {
  const Tasbihnumbers({Key? key}) : super(key: key);

  @override
  _TasbihnumbersState createState() => _TasbihnumbersState();
}

class _TasbihnumbersState extends State<Tasbihnumbers> {
  int count = 0;

  void increment() {
    setState(() {
      count = (count + 1) % 34;
    });
  }

  void reset() {
    setState(() {
      count = 0;
    });
  }

  void decrement() {
    setState(() {
      if (count > 0) {
        count--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: count.toString(),
                style: const TextStyle(
                  color: Color(0xFF06D6A0),
                  fontSize: 96,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
              const TextSpan(
                text: '/33',
                style: TextStyle(
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
                onTap: () {
                  increment();
                },
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
                onTap: () {
                  reset();
                },
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
                  decrement();
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
