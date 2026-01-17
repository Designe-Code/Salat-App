import 'package:flutter/material.dart';

class MosqueMarkerWidget extends StatelessWidget {
  final bool isUserLocation;

  const MosqueMarkerWidget({
    super.key,
    this.isUserLocation = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isUserLocation) {
      return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white,
            width: 4,
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
              blurRadius: 12,
              spreadRadius: 2,
            ),
          ],
        ),
        child: const Icon(
          Icons.my_location,
          color: Colors.white,
          size: 28,
        ),
      );
    }

    // Better mosque icon - using a custom design
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Mosque dome shape
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.place,
              color: Colors.white,
              size: 24,
            ),
          ),
          // Crescent moon on top
          Positioned(
            top: 2,
            child: Icon(
              Icons.brightness_3,
              color: Colors.white,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }
}
