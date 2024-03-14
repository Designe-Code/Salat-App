import 'package:flutter/material.dart';

class CustomQuranImageTab extends StatelessWidget {
  const CustomQuranImageTab({
    super.key,
    required this.icon,
    required this.title,
    required this.onPressed
  });

  final Widget icon;
  final String title;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        children: [
          icon,
          const SizedBox(height: 10),
          Text(title, style: Theme.of(context).textTheme.bodySmall)
        ],
      ),
    );
  }
}