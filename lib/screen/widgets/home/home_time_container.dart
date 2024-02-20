import 'package:flutter/material.dart';
import 'package:salati/helper/constant.dart';
import 'package:salati/helper/functions.dart';

class HomeTimeContainer extends StatefulWidget {
  const HomeTimeContainer({super.key});

  @override
  State<HomeTimeContainer> createState() => _HomeTimeContainerState();
}

class _HomeTimeContainerState extends State<HomeTimeContainer> {
  String currentTime = '';
  String hijriTime = '';

  @override
  void initState() {
    super.initState();
    _updateTime();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.92,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 0,
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 20, 0, 20),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.32,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(currentTime, style: Theme.of(context).textTheme.bodyLarge),
                  Text(
                    hijriTime,
                    softWrap: true,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.51,
            height: 130,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: Stack(
                alignment: AlignmentDirectional.centerEnd,
                children: [
                  Positioned(
                    left: MediaQuery.of(context).size.width * 0.08,
                    child: Container(
                      width: 210,
                      height: 210,
                      decoration: BoxDecoration(
                        color: getContainerColor(context).withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    left: MediaQuery.of(context).size.width * 0.14,
                    child: Container(
                      width: 170,
                      height: 170,
                      decoration: BoxDecoration(
                        color: getContainerColor(context).withOpacity(0.4),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Container(
                    width: 120,
                    height: MediaQuery.of(context).size.height * 0.16,
                    decoration: BoxDecoration(
                      color: getContainerColor(context).withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    child: Center(child: Image(image: AssetImage(getIconPath()),width: 70,)),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _updateTime() {
    setState(() {
      currentTime = getCurrentTime();
      hijriTime = getHijriTime();
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        _updateTime();
      }
    });
  }

  Color getContainerColor(BuildContext context) {
    int currentHour = int.parse(currentTime.split(":")[0]);

    if (currentHour >= 5 && currentHour < 7) {
      return Theme.of(context).colorScheme.onSecondary;
    } else if (currentHour >= 7 && currentHour < 12) {
      return Theme.of(context).colorScheme.onSecondary;
    } else if (currentHour >= 12 && currentHour < 14) {
      return Theme.of(context).colorScheme.onSecondary;
    } else if (currentHour >= 14 && currentHour < 17) {
      return Theme.of(context).colorScheme.onSecondary;
    } else if (currentHour >= 17 && currentHour < 19) {
      return Theme.of(context).colorScheme.onSecondary;
    } else {
      return Colors.purple;
    }
  }

  String getIconPath() {
    int currentHour = int.parse(currentTime.split(":")[0]);

    if (currentHour >= 5 && currentHour < 7) {
      return sunrise;
    } else if (currentHour >= 7 && currentHour < 12) {
      return morning;
    } else if (currentHour >= 12 && currentHour < 14) {
      return noon;
    } else if (currentHour >= 14 && currentHour < 17) {
      return afternoon;
    } else if (currentHour >= 17 && currentHour < 19) {
      return sunset;
    } else {
      return evening;
    }
  }
}
