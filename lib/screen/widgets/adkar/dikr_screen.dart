import 'package:flutter/material.dart';

class DikrScreen extends StatelessWidget {
  const DikrScreen({super.key, required this.imageAsset});

  final String imageAsset;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
      Positioned.fill(
        child: Image.asset(
          imageAsset,
          fit: BoxFit.cover,
        ),
      ),
      Positioned.fill(
        child: Container(
          color: Colors.black.withOpacity(0.6),
        ),
      ),
    ]);
  }
}
