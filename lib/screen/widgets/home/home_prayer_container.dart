import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salati/helper/constant.dart';
import 'package:salati/providers/prayer_provider.dart';
import 'package:salati/screen/widgets/home/widgets/prayer_list_item.dart';

class HomePrayerContainer extends StatefulWidget {
  const HomePrayerContainer({super.key});

  @override
  State<HomePrayerContainer> createState() => _HomePrayerContainerState();
}

class _HomePrayerContainerState extends State<HomePrayerContainer> {
  int _activeBellChange = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.92,
      height: MediaQuery.of(context).size.height * 0.35,
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
      child:
          Consumer<PrayerProvider>(builder: (context, prayerProvider, child) {
        prayerController.setPrayerTime(prayerProvider.timings);
        return ListView.builder(
            padding: const EdgeInsets.all(0),
            itemCount: prayerController.prayers.length,
            itemBuilder: (context, index) {
              return PrayerListItem(
                index: index,
                activeIndex: prayerProvider.activePrayerIndex,
                icon: prayerController.prayers[index].icon ?? '',
                adan: prayerController.prayers[index].adan ?? '',
                time: prayerController.prayers[index].time ?? '',
                bell: prayerController.prayers[index].bell ?? '',
                onPressedBell: () {
                  if (prayerController.prayers[index].bell == activeBell) {
                    prayerController.prayers[index].bell = inactiveBell;
                  } else {
                    prayerController.prayers[index].bell = activeBell;
                  }
                  setState(() {
                    _activeBellChange = _activeBellChange + 1;
                  });
                },
              );
            });
      }),
    );
  }
}
