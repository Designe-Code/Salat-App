import 'package:flutter/material.dart';

class SettingsContainer extends StatelessWidget {
  const SettingsContainer({
    super.key,
    required this.iconData,
    required this.text,
    required this.additionalWidget,
    this.iconColor = Colors.black,
  });

  final Widget additionalWidget;
  final Color iconColor;
  final IconData iconData;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.secondary.withOpacity(0.02),
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.09),
            spreadRadius: 0,
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).colorScheme.background,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 150,
              child: Row(
                children: [
                  Icon(
                    iconData,
                    size: 24.0,
                    color: iconColor,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    text,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ],
              ),
            ),
            additionalWidget,
          ],
        ),
      ),
    );
  }
}
