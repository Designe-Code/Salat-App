import 'package:flutter/material.dart';

class NextAdan extends StatelessWidget {
  const NextAdan({super.key, required this.nextAdan, required this.time});

  final String nextAdan;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.access_time,
                color: Theme.of(context).colorScheme.onPrimary, size: 19)
          ],
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(nextAdan, style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 2),
            Text(time, style: Theme.of(context).textTheme.bodySmall),
          ],
        )
      ],
    );
  }
}
