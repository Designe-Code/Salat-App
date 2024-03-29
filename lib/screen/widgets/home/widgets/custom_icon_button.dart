import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget{
  const CustomIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.iconlabel,
    required this.heroTag
  });

  final String icon;
  final void Function() onPressed;
  final String iconlabel;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 50,
          height: 50,
          child: FloatingActionButton(
            heroTag: heroTag,
            backgroundColor: Theme.of(context).colorScheme.background,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)
            ),
            onPressed: onPressed,
            child: Image(image: AssetImage(icon), width: 35, height: 35),
          ),
        ),
        const SizedBox(height: 8),
        Text(iconlabel, style: Theme.of(context).textTheme.bodySmall)
      ],
    );
  }
}