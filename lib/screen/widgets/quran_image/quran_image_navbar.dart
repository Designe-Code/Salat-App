import 'package:flutter/material.dart';
import 'package:salati/helper/constant.dart';
import 'package:salati/screen/widgets/quran_image/widgets/custom_quran_image_tab.dart';

class QuranImageNavBar extends StatefulWidget {
  const QuranImageNavBar({super.key});

  @override
  State<QuranImageNavBar> createState() => _QuranImageNavBarState();
}

class _QuranImageNavBarState extends State<QuranImageNavBar> {
  bool isBookMarkActive = false;
  bool isPlay = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        color: Theme.of(context).colorScheme.background,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFDDDDDD).withOpacity(0.5),
            blurRadius: 2,
            spreadRadius: 0,
            offset: const Offset(-1, -1)
          ),
          BoxShadow(
            color: const Color(0xFFDDDDDD).withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(-5, 5)
          ),
          BoxShadow(
            color: const Color(0xFFDDDDDD).withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(5, -5)
          ),
          BoxShadow(
            color: const Color(0xFFDDDDDD).withOpacity(0.9),
            blurRadius: 13,
            spreadRadius: 0,
            offset: const Offset(5, 5)
          ),
        ]
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomQuranImageTab(
                onPressed: () {},
                icon: const Image(image: AssetImage(traduction)),
                title: 'translation'
              ),
              CustomQuranImageTab(
                onPressed: () {
                  setState(() {
                    isPlay = !isPlay;
                  });
                },
                icon: IconButton(
                  style: ButtonStyle(
                    shape: const MaterialStatePropertyAll(CircleBorder()),
                    backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary)
                  ),
                  padding: const EdgeInsets.all(0),
                  iconSize: 30,
                  alignment: Alignment.center,
                  constraints: const BoxConstraints(
                    minWidth: 50,
                    minHeight: 50
                  ),
                  onPressed: () {
                    setState(() {
                      isPlay = !isPlay;
                    });
                  },
                  icon: Icon(
                    isPlay ? Icons.pause : Icons.play_arrow,
                    color: Theme.of(context).colorScheme.background,
                  ),
                ),
                title: isPlay ? 'Pause' : 'Play'
              ),
              CustomQuranImageTab(
                onPressed: () {
                  setState(() {
                    isBookMarkActive = !isBookMarkActive;
                  });
                },
                icon: Image(image: AssetImage(isBookMarkActive ? bookMark : bookMarkInactive)),
                title: 'bookMark'
              )
            ]
          ),
        ],
      ),
    );
  }
}