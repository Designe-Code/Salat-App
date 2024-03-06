import 'package:flutter/material.dart';

class CustomLocation extends StatelessWidget{
  const CustomLocation({super.key, required this.location});

  final String location;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.location_on_outlined, color: Theme.of(context).colorScheme.onPrimary, size: 19)
          ],
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Location', style: Theme.of(context).textTheme.bodySmall
            ),
            const SizedBox(height: 2),
            Text(location, style: Theme.of(context).textTheme.bodySmall),
          ],
        )
      ],
    );
  }
}