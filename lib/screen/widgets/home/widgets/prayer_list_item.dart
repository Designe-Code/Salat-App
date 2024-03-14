import 'package:flutter/material.dart';

class PrayerListItem extends StatelessWidget {
  const PrayerListItem({
    super.key,
    required this.index,
    required this.activeIndex,
    required this.icon,
    required this.adan,
    required this.time,
    required this.bell,
    required this.onPressedBell
  });

  final int index;
  final int activeIndex;
  final String icon;
  final String adan;
  final String time;
  final String bell;
  final Function() onPressedBell;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.041,
      child: Container(
        decoration: BoxDecoration(
          color: index == activeIndex ? Theme.of(context).colorScheme.secondary : Theme.of(context).colorScheme.background,
          borderRadius: const BorderRadius.all(Radius.circular(9))
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(child: Image(image: AssetImage(icon))),
            Expanded(child: Text(adan, style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: index == activeIndex ? Theme.of(context).colorScheme.background : Theme.of(context).colorScheme.secondary,
            ))),
            Expanded(child: Text(time, style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: index == activeIndex ? Theme.of(context).colorScheme.background : Theme.of(context).colorScheme.secondary,
            ))),
            Expanded(
              child: IconButton(
                icon: Image(image: AssetImage(bell)),
                onPressed: onPressedBell,
              )
            ),
          ],
        ),
      ),
    );
  }
}