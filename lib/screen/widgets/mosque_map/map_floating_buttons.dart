import 'package:flutter/material.dart';

class MapFloatingButtons extends StatelessWidget {
  final VoidCallback onRefresh;
  final VoidCallback onMyLocation;

  const MapFloatingButtons({
    super.key,
    required this.onRefresh,
    required this.onMyLocation,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Refresh button
        FloatingActionButton(
          heroTag: 'refresh',
          onPressed: onRefresh,
          backgroundColor: Theme.of(context).colorScheme.background,
          child: Icon(
            Icons.refresh,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 12),
        // My location button
        FloatingActionButton(
          heroTag: 'location',
          onPressed: onMyLocation,
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: const Icon(
            Icons.my_location,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
